extends Control

signal level_started

func _input(event):
	if event.is_action("ui_accept"):
		_start_level()
		set_process_input(false)

func level_loaded() -> void:
	visible = true
	get_tree().paused = true

func _start_level() -> void:
	visible = false
	get_tree().paused = false
	emit_signal("level_started")