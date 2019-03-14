extends Node2D

func _ready():
	# Connect the signal for when a player falls to the bottom of the screen to the function to handle the game being over
	assert($FallDetector.connect("area_exited", self, "gameOver") == 0)
	assert($LeftScreenDetector.connect("area_exited", $Character, "playerLeftScreen", [screen_side.LEFT]) == 0)
	assert($RightScreenDetector.connect("area_exited", $Character, "playerLeftScreen", [screen_side.RIGHT]) == 0)

func gameOver(area: Area2D) -> void:
	get_tree().change_scene("res://interface/game_over/GameOverScreen.tscn")