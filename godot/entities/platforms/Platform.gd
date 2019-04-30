extends Area2D

class_name Platform

func land() -> void:
	$AudioStreamPlayer.play()

func remove_from_game() -> void:
	call_deferred("queue_free")
	print('removing')