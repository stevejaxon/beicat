extends Node2D

const IDLE_TIME_SECONDS = 5
const WALK_TIME_SECONDS = 5

func _ready():
	_animate_character()

func _animate_character() -> void:
	$Cooper/Sprite.play("idle")
	$Timer.start(IDLE_TIME_SECONDS)
	yield($Timer, "timeout")
	$Cooper/Sprite.play("walking")
	$Timer.start(WALK_TIME_SECONDS)
	yield($Timer, "timeout")
	$Cooper/Sprite.play("idle")
	yield($Cooper/Sprite, "animation_finished")
	$Cooper/Sprite.flip_h = true
	$Cooper/Sprite.play("walking")
	$Timer.start(WALK_TIME_SECONDS)
	yield($Timer, "timeout")
	$Cooper/Sprite.flip_h = false
	$Cooper/Sprite.play("idle")
	$Timer.stop()