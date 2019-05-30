extends Node2D

signal level_load_completed

const SCREEN_HEIGHT: int = 1280
const MAX_LEVELS_PER_DIFFICULTY_STAGE: int = 10
const NUM_SUCCESSFUL_JUMPS_BEFORE_REMOVING_GROUND: int = 2

var STAGE_TO_PLATFORM_SIZE_MAP = {
	0: 0.3,
	1: 0.275,
	2: 0.25,
	3: 0.25,
	4: 0.225,
	5: 0.2,
	6: 0.2,
	7: 0.175,
	8: 0.15,
	9: 0.15,
	10: 0.1,
	11: 0.1,
	12: 0.075,
	13: 0.06,
	14: 0.05
}

var level_loader: LevelLoader = LevelLoader.new();
var last_loaded_platform
var difficulty_stage: int = 0
var stage_progress: int = 0
var previously_seen_level_id: int = -1
var previously_previously_seen_level_id: int = -1
var num_successful_jumps: int = 0;

func _ready():
	# Connect the signal for when a player falls to the bottom of the screen to the function to handle the game being over
	assert($FallDetector.connect("body_exited", self, "gameOver") == 0)
	assert($Cooper.connect("free_falling", self, "gameOver") == 0)
	assert(self.connect("level_load_completed", $CanvasLayer/StartLevel, "level_loaded") == 0)
	assert($Cooper.connect("restart_level", $CanvasLayer/StartLevel, "level_loaded") == 0)
	assert($CanvasLayer/StartLevel.connect("level_started", self, "_play_level_music") == 0)
	assert($CanvasLayer/StartLevel.connect("level_started", $Cooper, "start") == 0)
	assert(global_variables.connect("score_updated", $hud, "updateScore") == 0)
	_load_level()
	emit_signal("level_load_completed")

func _load_level() -> void:
	var platformsData = level_loader.load("data", difficulty_stage, _get_platform_size())
	var y_offset = 0
	if last_loaded_platform != null:
		y_offset = SCREEN_HEIGHT - last_loaded_platform.position.y
	for data in platformsData:
		data.position = Vector2(data.position.x, (data.position.y - y_offset))
		_display_platform(data.platform, data.position)
		_connect_platform_signals(data.platform)
	last_loaded_platform = platformsData[platformsData.size() -1]

func _display_platform(platform, absolutePosition: Vector2) -> void:
	platform.position = absolutePosition
	$Platforms.call_deferred("add_child", platform)

func _connect_platform_signals(platform: Platform) -> void:
	assert(platform.connect("platform_landed_on", self, "_handle_platform_landed_on") == 0)

# We trigger the loading of the next stage's levels into the game state upon a user reaching the start of the previous stage.
# Since we can't be certain which platform will be the first that the user lands on, every platform broadcasts 
func _handle_platform_landed_on(stage: int, level_id: int) -> void:
	global_variables.updateScore(_calculate_score_for_landing_on_platform(stage))
	num_successful_jumps += 1
	if num_successful_jumps == NUM_SUCCESSFUL_JUMPS_BEFORE_REMOVING_GROUND:
		$Ground.freeGroundFromGame()
	# Check to make sure that we haven't already loaded a level for the next step of progress in the stage
	if level_id != previously_seen_level_id and level_id != previously_previously_seen_level_id:
		previously_previously_seen_level_id = previously_seen_level_id
		previously_seen_level_id = level_id
		if stage_progress + 1 == _calculate_number_of_levels_per_stage(stage):
			difficulty_stage +=1
			stage_progress = 0
		else:
			stage_progress += 1
		_load_level()

func _calculate_score_for_landing_on_platform(stage: int) -> int:
	# The function x^2 - x + 1 seemed like a reasonable exponential function based on plotting / trial and error.
	return stage*stage - stage + 1;

func _calculate_number_of_levels_per_stage(stage: int) -> int:
	return int(min(0.66*stage + 3, MAX_LEVELS_PER_DIFFICULTY_STAGE))

func _play_level_music() -> void:
	if not $AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.play()

func _get_platform_size() -> float:
	if difficulty_stage < 0:
		return STAGE_TO_PLATFORM_SIZE_MAP.get(0)
	elif not STAGE_TO_PLATFORM_SIZE_MAP.has(difficulty_stage):
		return STAGE_TO_PLATFORM_SIZE_MAP.get(STAGE_TO_PLATFORM_SIZE_MAP.size()-1)
	else:
		return STAGE_TO_PLATFORM_SIZE_MAP.get(difficulty_stage)

func gameOver(area: Area2D) -> void:
	assert(get_tree().change_scene("res://interface/game_over/GameOverScreen.tscn") == 0)