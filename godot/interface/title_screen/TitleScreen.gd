extends Node2D

const IDLE_TIME_SECONDS = 10
const WALK_TIME_SECONDS = 1

func _ready():
	_animate_character()

func _animate_character() -> void:
	print('start')
	$Cooper/Sprite.play("idle")
	$Timer.start(IDLE_TIME_SECONDS)
	yield($Timer, "timeout")
	print('about to walk')
	$Cooper/Sprite.play("walking")
	$Timer.start(WALK_TIME_SECONDS)
	yield($Timer, "timeout")
	$Cooper/Sprite.play("idle")