extends KinematicBody2D

const FLOOR_DIRECTION = Vector2(0, -1)
const GRAVITY = 9.8

export var jump_height = -10

class_name Character

var velocity = Vector2(0,0)

func _ready():
	$EntityDetection.connect("body_entered", self, "landed_on")

func _process(delta):
	velocity.y = velocity.y + (GRAVITY * delta)
	move_and_collide(velocity)
	pass

func _input(event):
	pass

func landed_on(body) -> void:
	velocity.y = jump_height
	pass