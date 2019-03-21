extends KinematicBody2D

signal scroll_level (amount, scroll_speed)

const GRAVITY: float = 300.0
const SCREEN_WIDTH: int = 720
const SCROLL_TO_Y_POSITION = 1260
const REGULAR_JUMP_SCROLL_SPEED = 3
onready var PLATFORM_COLLISION_DETECTOR: CollisionShape2D = get_node("PlatformDetection/CollisionShape2D")

# The jump height is negative because down on the Y axis in games in positive, therefore, up on the y axis is negative
export var jump_height = -50
export var horizontal_speed = 5

class_name Character

var remaining_jump_height = 0

func _ready():
	assert($PlatformDetection.connect("area_entered", self, "landed_on") == 0)
	_enableInteractingWithPlatforms()

func _process(delta):
	print(delta)
	var amount_jumped = 0
	var gravity_to_apply = GRAVITY * delta
	if remaining_jump_height < 0:
		amount_jumped = remaining_jump_height + delta
		remaining_jump_height = amount_jumped + gravity_to_apply
	var new_vertical_position = position.y + gravity_to_apply + amount_jumped
	var pointer_position = 	get_global_mouse_position()		
	if not PLATFORM_COLLISION_DETECTOR.disabled and amount_jumped < 0:
		_preventInteractingWithPlatforms()
	elif PLATFORM_COLLISION_DETECTOR.disabled and amount_jumped >= 0:
		_enableInteractingWithPlatforms()

	position = Vector2(clamp(pointer_position.x, 0, SCREEN_WIDTH), new_vertical_position)

func landed_on(body: Area2D) -> void:
	remaining_jump_height = jump_height
	var platform_y_position = body.position.y
	var scroll_distance = SCROLL_TO_Y_POSITION - platform_y_position
	emit_signal("scroll_level", scroll_distance, REGULAR_JUMP_SCROLL_SPEED )

func playerLeftScreen(area: Area2D, screenSide) -> void:
	if screenSide == screen_side.LEFT:
		position.x = position.x + SCREEN_WIDTH
	elif screenSide == screen_side.RIGHT:
		position.x = position.x - SCREEN_WIDTH
		
func _preventInteractingWithPlatforms():
	PLATFORM_COLLISION_DETECTOR.disabled = true
	
func _enableInteractingWithPlatforms():
	PLATFORM_COLLISION_DETECTOR.disabled = false