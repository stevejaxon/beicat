extends Node

class_name LevelLoader

const Platform = preload("res://entities/platforms/DestructableGemsPlatform.tscn")
const LEVELS_PARENT_DIR: String = "res://assets/levels"

# A map which stores the number of the available generated levels to chose from for a given stage
var NUM_LEVEL_OPTIONS_MAP = {}

var directory: Directory = Directory.new()
var level: int = 0
var current_stage: int = 0
var current_platforms_size: float

func _init():
	assert(directory.open(LEVELS_PARENT_DIR) == OK)
	randomize()

func load(stage: int, platforms_size: float) -> Array:
	if stage > current_stage:
		current_stage = stage
		current_platforms_size = platforms_size
	return _load(stage)

func _load(stage: int) -> Array:
	# Make sure we don't accidentally call this expensive function more than is necessary
	if not NUM_LEVEL_OPTIONS_MAP.has(stage):
		_populate_available_level_options(stage)
	var random_level = randi() % (NUM_LEVEL_OPTIONS_MAP.get(stage))
	return _load_from_file(stage, random_level)

func _load_from_file(stage:int, level: int) -> Array:
	var path = str(LEVELS_PARENT_DIR.plus_file(String(stage)).plus_file(String(level)), ".tres")
	var platform_data = JSON.parse(_read_json_from_file(path))
	return _create_platforms_from_json(platform_data)
	
func _read_json_from_file(path: String) -> String:
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content

func _populate_available_level_options(stage: int) -> void:
	NUM_LEVEL_OPTIONS_MAP[stage] = _count_num_level_options(stage)

func _count_num_level_options(stage: int) -> int:
	assert(directory.change_dir(String(stage)) == OK)
	
	directory.list_dir_begin(true, true)
	var num_levels = 0
	var file_name = directory.get_next()
	while (file_name != ""):
		num_levels += 1
		file_name = directory.get_next()
	
	directory.list_dir_end()
	
	# navigate back to the parent, level, directory
	assert(directory.change_dir("..") == OK)
	return num_levels

func _createNewPlatformInstance(gemType: int) -> Platform:
	var platform = Platform.instance()
	platform.changeGemType(gemType)
	platform.set_stage_and_level(current_stage,level)
	platform.changeGemSize(current_platforms_size)
	return platform

func _addNewPlatformToLevel(platforms: Array, positionInLevel: Vector2, gemType: int) -> void:
	var platform = _createNewPlatformInstance(gemType)
	platforms.append({ "position": positionInLevel, "platform": platform })

func _create_platforms_from_json(json:  JSONParseResult) -> Array:
	var platforms = []
	for element in json.result:
		_addNewPlatformToLevel(platforms, Vector2(element.x, element.y), element.gemType)
	return platforms