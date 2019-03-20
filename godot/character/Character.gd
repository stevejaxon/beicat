extends KinematicBody2D

signal scroll_level (amount, scroll_speed)

const GRAVITY: float = 9.8
const SCREEN_WIDTH: int = 720
const SCROLL_TO_Y_POSITION = 1260
const REGULAR_JUMP_SCROLL_SPEED = 3
onready var PLATFORM_COLLISION_DETECTOR: CollisionShape2D = get_node("PlatformDetection/CollisionShape2D")

# The jump height is negative because down on the Y axis in games in positive, therefore, up on the y axis is negative
export var jump_height = -8
export var horizontal_speed = 5
export var max_horizontal_speed = 5

class_name Character

var velocity = Vector2(0,0)

func _ready():
	assert($PlatformDetection.connect("area_entered", self, "landed_on") == 0)

func _process(delta):
	var pointer = 	get_local_mouse_position()
	velocity.y = velocity.y + (GRAVITY * delta)
	if not PLATFORM_COLLISION_DETECTOR.disabled and velocity.y < 0:
		_preventInteractingWithPlatforms()
	elif PLATFORM_COLLISION_DETECTOR.disabled and velocity.y > 0:
		_enableInteractingWithPlatforms()
	move_and_collide(velocity)

func _input(event):
	if event.is_action_pressed("move_right"):
		velocity.x = min(velocity.x + horizontal_speed, max_horizontal_speed)
	elif event.is_action_pressed("move_left"):
		velocity.x = max(velocity.x + -horizontal_speed, -max_horizontal_speed)

func landed_on(body: Area2D) -> void:
	velocity.y = jump_height
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