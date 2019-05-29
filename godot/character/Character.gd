extends KinematicBody2D

signal free_falling
signal restart_level

enum Status {ON_GROUND, JUMPING, FALLING}

const GRAVITY: float = 50.0
const TERMINAL_VELOCITY: float = 75.0
const HORIZONTAL_SPEED: float = 35.0
const SCREEN_WIDTH: int = 720
const MAX_FALL_TIME_IN_SECS: float = 3.0
const PLATFORM_COLLISION_LAYER_BIT: int = 1

# The jump height is negative because down on the Y axis in games in positive, therefore, up on the y axis is negative
export var jump_height = -1
# A variable for use when the character is re-used outside of the main game, e.g in the menu system
export var in_game: bool = true

class_name Character

var speed_y: float = 0.0
var speed_x: float = 0.0
var character_status: int = Status.ON_GROUND
var previous_mouse_x_position: float = 0.0

func _ready():
	assert($PlatformDetection.connect("area_entered", self, "landed_on") == 0)
	assert($PlatformSweeper.connect("area_entered", self, "platform_left_game") == 0)
	assert(jump_height < 0)
	if not in_game:
		set_process(false)
	else:
		set_process(true)

func start():
	_jump()

func _process(delta):
	if character_status == Status.ON_GROUND:
		_handle_player_on_the_ground()
	else:
		_handle_player_jumping(delta)

func _handle_player_on_the_ground() -> void:
	$Sprite.play("idle")
	previous_mouse_x_position = SCREEN_WIDTH/2
	_face_pointer()

func _handle_player_jumping(delta) -> void:
	# Apply the gravity
	speed_y = min(speed_y + (GRAVITY * delta), TERMINAL_VELOCITY)
	
	if speed_y >= 0 and not character_status == Status.FALLING:
		$Sprite.play("falling")
		character_status = Status.FALLING
	
	_face_pointer()
	
	# ensure the character does not go off of the screen
	var pointer_position = get_global_mouse_position()
	var remaining_x_distance = clamp(pointer_position.x, 0, SCREEN_WIDTH) - position.x
	speed_x = HORIZONTAL_SPEED * delta * remaining_x_distance
	previous_mouse_x_position = pointer_position.x
	
	var collision = move_and_collide(Vector2(speed_x, speed_y))
	# If the player has landed back on the floor after the initial jump
	# Should not happen often - ground disappears after the player has landed on a small number of platforms.
	if collision != null:
		character_status = Status.ON_GROUND
		speed_y = 0.0
		emit_signal("restart_level")

func landed_on(platform: Platform) -> void:
	if platform == null || ! platform.get_collision_layer_bit(PLATFORM_COLLISION_LAYER_BIT):
		return
	$FallTimer.start(MAX_FALL_TIME_IN_SECS)
	platform.land()
	_jump()
	
func _jump():
	$Sprite.play("idle")
	$Sprite.play("jumping")
	speed_y = jump_height
	character_status = Status.JUMPING

func _face_pointer():
	var pointer_position = get_global_mouse_position()
	# ensure that the animated sprite is looking in the correct direction
	if pointer_position.x < previous_mouse_x_position:
		$Sprite.flip_h = true
	elif pointer_position.x > previous_mouse_x_position:
		$Sprite.flip_h = false

func platform_left_game(platform: Platform) -> void:
	if platform == null || ! platform.get_collision_layer_bit(PLATFORM_COLLISION_LAYER_BIT):
		return
	platform.remove_from_game()

func _on_FallTimer_timeout():
	# Sends the second signal null because the GameOver function is also mapped to the signal from the
	# Area detecting the character passing the bottom of the screen and that signal sends an Area2D along with the call.
	# The code is a bit quick and dirty...
	emit_signal("free_falling", null)
	$FallTimer.stop()
	call_deferred("queue_free")
