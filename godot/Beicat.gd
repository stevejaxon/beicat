extends Node2D

signal level_load_completed

const SCREEN_HEIGHT: int = 1280
const LEVELS_PER_DIFFICULTY_STAGE = 8

var last_loaded_platform
var difficulty_stage: int = 0
var difficulty_level: int = 0

func _ready():
	# Connect the signal for when a player falls to the bottom of the screen to the function to handle the game being over
	assert($FallDetector.connect("body_exited", self, "gameOver") == 0)
	assert(self.connect("level_load_completed", $CanvasLayer/StartLevel, "level_loaded") == 0)
	assert($CanvasLayer/StartLevel.connect("level_started", self, "_play_level_music") == 0)
	_load_level()
	emit_signal("level_load_completed")

func _load_level() -> void:
	var platformsData = LevelLoader.load("data", difficulty_stage, difficulty_level)
	var y_offset = 0
	if last_loaded_platform != null:
		y_offset = SCREEN_HEIGHT - last_loaded_platform.position.y
	for data in platformsData:
		data.position = Vector2(data.position.x, (data.position.y - y_offset))
		_display_platform(data.platform, data.position)
		_connect_platform_signals(data.platform)
	last_loaded_platform = platformsData[platformsData.size() -1]
	difficulty_level += 1
	if difficulty_level == LEVELS_PER_DIFFICULTY_STAGE:
		difficulty_stage +=1
		difficulty_level = 0

func _display_platform(platform, absolutePosition: Vector2) -> void:
	platform.position = absolutePosition
	$Platforms.call_deferred("add_child", platform)
	# $Platforms.add_child(platform)

func _connect_platform_signals(platform: Platform) -> void:
	assert(platform.connect("platform_exited", self, "_handle_platform_exit") == 0)

func _handle_platform_exit(stage: int, level: int) -> void:
	if stage == difficulty_stage && level < difficulty_level:
		_load_level()

func _play_level_music() -> void:
	$AudioStreamPlayer.play()

func gameOver(area: Area2D) -> void:
	assert(get_tree().change_scene("res://interface/game_over/GameOverScreen.tscn") == 0)