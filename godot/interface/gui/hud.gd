extends Node

func updateScore() -> void:
	$VBoxContainer/HBoxContainer/ScoreValue.set_text(String(global_variables.score))