extends Node

func _process(delta) -> void:
	$VBoxContainer/HBoxContainer2/FPSValue.set_text(String(Engine.get_frames_per_second()))

func updateScore() -> void:
	$VBoxContainer/HBoxContainer/ScoreValue.set_text(String(global_variables.score))