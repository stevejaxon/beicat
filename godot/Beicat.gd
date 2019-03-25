extends Node2D

signal level_load_completed

func _ready():
	# Connect the signal for when a player falls to the bottom of the screen to the function to handle the game being over
	assert($FallDetector.connect("body_exited", self, "gameOver") == 0)
	_connect_platforms()
	assert(self.connect("level_load_completed", $CanvasLayer/StartLevel, "level_loaded") == 0)
	emit_signal("level_load_completed")

func _connect_platforms() -> void:
	for platform in $Platforms.get_children():
		assert($Cooper.connect("scroll_level", platform, "scrollDown") == 0)
		assert($FallDetector.connect("area_entered", platform, "leftScreen") == 0)

func gameOver(area: Area2D) -> void:
	assert(get_tree().change_scene("res://interface/game_over/GameOverScreen.tscn") == 0)