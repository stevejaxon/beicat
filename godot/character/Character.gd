extends KinematicBody2D

const GRAVITY: float = 350.0
const SCREEN_WIDTH: int = 720
const SCROLL_TO_Y_POSITION: int = 1300
const REGULAR_JUMP_SCROLL_SPEED: int = 15
const JUMP_END_THRESHOLD: int = -110

# The jump height is negative because down on the Y axis in games in positive, therefore, up on the y axis is negative
export var jump_height = -500
# A variable for use when the character is re-used outside of the main game, e.g in the menu system
export var in_game: bool = true

class_name Character

var remaining_jump_height: float = 0.0
var previous_mouse_x_position: float = 0.0

func _ready():
	assert($PlatformDetection.connect("area_entered", self, "landed_on") == 0)
	if not in_game:
		set_process(false)
	else:
		set_process(true)
		$Sprite.play("falling")

func _process(delta):
	var amount_jumped = 0
	var new_vertical_position = 0
	if remaining_jump_height < JUMP_END_THRESHOLD:
		amount_jumped = remaining_jump_height * delta
		remaining_jump_height = remaining_jump_height - amount_jumped
		new_vertical_position = position.y + amount_jumped
	else:
		remaining_jump_height = 0
		new_vertical_position = position.y + (GRAVITY * delta)
		
	var pointer_position = 	get_global_mouse_position()		
	if amount_jumped >= 0:
		$Sprite.play("falling")
	
	# ensure that the animated sprite is looking in the correct direction
	if pointer_position.x < previous_mouse_x_position:
		$Sprite.flip_h = true
	elif pointer_position.x > previous_mouse_x_position:
		$Sprite.flip_h = false
	previous_mouse_x_position = pointer_position.x
	
	position = Vector2(clamp(pointer_position.x, 0, SCREEN_WIDTH), new_vertical_position)

func landed_on(platform: Platform) -> void:
	platform.land()
	$Sprite.play("jumping")
	remaining_jump_height = jump_height