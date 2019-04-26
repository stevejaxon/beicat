extends KinematicBody2D

const GRAVITY: float = 50.0
const SCREEN_WIDTH: int = 720
const SCROLL_TO_Y_POSITION: int = 1300

# The jump height is negative because down on the Y axis in games in positive, therefore, up on the y axis is negative
export var jump_height = -1
# A variable for use when the character is re-used outside of the main game, e.g in the menu system
export var in_game: bool = true

class_name Character

var speed_y: float = 0.0
var speed_x: float = 0.0
var previous_mouse_x_position: float = 0.0

func _ready():
	assert($PlatformDetection.connect("area_entered", self, "landed_on") == 0)
	assert(jump_height < 0)
	if not in_game:
		set_process(false)
	else:
		set_process(true)
		$Sprite.play("falling")

func _process(delta):
	# Apply the gravity
	speed_y += GRAVITY * delta
	
	if speed_y >= 0:
		$Sprite.play("falling")
	
	var pointer_position = 	get_global_mouse_position()
	# ensure that the animated sprite is looking in the correct direction
	if pointer_position.x < previous_mouse_x_position:
		$Sprite.flip_h = true
	elif pointer_position.x > previous_mouse_x_position:
		$Sprite.flip_h = false
		
	previous_mouse_x_position = pointer_position.x
	
	# move_and_collide(Vector2(clamp(pointer_position.x, 0, SCREEN_WIDTH), speed_y))
	move_and_collide(Vector2(speed_x, speed_y))

func landed_on(platform: Platform) -> void:
	platform.land()
	$Sprite.play("idle")
	$Sprite.play("jumping")
	speed_y = jump_height