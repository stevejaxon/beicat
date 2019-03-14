extends KinematicBody2D

signal scroll_level

const GRAVITY: float = 9.8
const SCREEN_WIDTH: int = 720

# The jump height is negative because down on the Y axis in games in positive, therefore, up on the y axis is negative
export var jump_height = -10
export var horizontal_speed = 5
export var max_horizontal_speed = 5

class_name Character

var velocity = Vector2(0,0)

func _ready():
	assert($PlatformDetection.connect("area_entered", self, "landed_on") == 0)

func _process(delta):
	velocity.y = velocity.y + (GRAVITY * delta)
	move_and_collide(velocity)

func _input(event):
	if event.is_action_pressed("move_right"):
		velocity.x = min(velocity.x + horizontal_speed, max_horizontal_speed)
	elif event.is_action_pressed("move_left"):
		velocity.x = max(velocity.x + -horizontal_speed, -max_horizontal_speed)

func landed_on(body: Area2D) -> void:
	velocity.y = jump_height
	emit_signal("scroll_level", abs(jump_height) * 10, 1 )

func playerLeftScreen(area: Area2D, screenSide) -> void:
	if screenSide == screen_side.LEFT:
		position.x = position.x + SCREEN_WIDTH
	elif screenSide == screen_side.RIGHT:
		position.x = position.x - SCREEN_WIDTH