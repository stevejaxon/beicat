extends Area2D

signal platform_exited

var stage: int
var level: int

class_name Platform

func set_stage_and_level(_stage: int, _level: int):
	stage = _stage
	level = _level

func land() -> void:
	$AudioStreamPlayer.play()
	prints('lands', stage, level)
	emit_signal("platform_exited", stage, level)

func remove_from_game() -> void:
	call_deferred("queue_free")