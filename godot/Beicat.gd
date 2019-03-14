extends Node2D

func _ready():
	# Connect the signal for when a player falls to the bottom of the screen to the function to handle the game being over
	$FallDetector.connect("body_entered", self, "gameOver")

func gameOver() -> void:
	print("game over")
	get_tree().change_scene("res://interface/game_over/GameOverScreen.tscn")