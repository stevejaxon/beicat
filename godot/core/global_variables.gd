extends Node

signal score_updated

var score: int = 0

func updateScore(amount: int) -> void:
	# Prevent the unlikely situation where the integer overflows
	if score + amount > 0:
		score += amount
		emit_signal("score_updated")