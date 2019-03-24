extends Control

func level_loaded() -> void:
	visible = true
	get_tree().paused = true