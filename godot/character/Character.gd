extends KinematicBody2D

signal free_falling

const GRAVITY: float = 50.0
const TERMINAL_VELOCITY: float = 75.0
const HORIZONTAL_SPEED: float = 35.0
const SCREEN_WIDTH: int = 720
const MAX_FALL_TIME_IN_SECS: float = 3.0

# The jump height is negative because down on the Y axis in games in positive, therefore, up on the y axis is negative
export var jump_height = -1
# A variable for use when the character is re-used outside of the main game, e.g in the menu system
export var in_game: bool = true

class_name Character

var speed_y: float = 0.0
var speed_x: float = 0.0
var is_falling: bool = true
var previous_mouse_x_position: float = 0.0

func _ready():
	assert($PlatformDetection.connect("area_entered", self, "landed_on") == 0)
	assert($PlatformSweeper.connect("area_entered", self, "platform_left_game") == 0)
	assert(jump_height < 0)
	if not in_game:
		set_process(false)
	else:
		set_process(true)
		$Sprite.play("falling")

func _process(delta):
	# Apply the gravity
	speed_y = min(speed_y + (GRAVITY * delta), TERMINAL_VELOCITY)
	
	if speed_y >= 0 and not is_falling:
		$Sprite.play("falling")
		is_falling = true
	
	var pointer_position = get_global_mouse_position()
	# ensure that the animated sprite is looking in the correct direction
	if pointer_position.x < previous_mouse_x_position:
		$Sprite.flip_h = true
	elif pointer_position.x > previous_mouse_x_position:
		$Sprite.flip_h = false
	
	# ensure the character does not go off of the screen
	var remaining_x_distance = clamp(pointer_position.x, 0, SCREEN_WIDTH) - position.x
	speed_x = HORIZONTAL_SPEED * delta * remaining_x_distance
	previous_mouse_x_position = pointer_position.x
	
	move_and_collide(Vector2(speed_x, speed_y))

func landed_on(platform: Platform) -> void:
	$FallTimer.start(MAX_FALL_TIME_IN_SECS)
	platform.land()
	$Sprite.play("idle")
	$Sprite.play("jumping")
	speed_y = jump_height
	is_falling = false

func platform_left_game(platform: Platform) -> void:
	platform.remove_from_game()

func _on_FallTimer_timeout():
	# Sends the second signal null because the GameOver function is also mapped to the signal from the
	# Area detecting the character passing the bottom of the screen and that signal sends an Area2D along with the call.
	# The code is a bit quick and dirty...
	emit_signal("free_falling", null)
	$FallTimer.stop()
	call_deferred("queue_free")
