extends Node2D

func _ready():
	# Connect the signal for when a player falls to the bottom of the screen to the function to handle the game being over
	assert($FallDetector.connect("body_exited", self, "gameOver") == 0)
	assert($LeftScreenDetector.connect("body_exited", $Character, "playerLeftScreen", [screen_side.LEFT]) == 0)
	assert($RightScreenDetector.connect("body_exited", $Character, "playerLeftScreen", [screen_side.RIGHT]) == 0)


	for platform in $Platforms.get_children():
		assert($Character.connect("scroll_level", platform, "scrollDown") == 0)
		assert($FallDetector.connect("area_entered", platform, "leftScreen") == 0)
	_connectPlatformFactories()

func gameOver(area: Area2D) -> void:
	get_tree().change_scene("res://interface/game_over/GameOverScreen.tscn")

func _connectPlatformFactories():
	for platformFactory in $PlatformFactories.get_children():
		assert($Character.connect("scroll_level", platformFactory, "instance") == 0)
		assert(platformFactory.connect("new_platform", self, "_addPlatformToScene") == 0)

func _addPlatformToScene(platform) -> void:
	call_deferred("add_child", platform)
	assert($Character.connect("scroll_level", platform, "scrollDown") == 0)
	assert($FallDetector.connect("area_entered", platform, "leftScreen") == 0)