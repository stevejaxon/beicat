extends Node

class_name LevelLoader

const Platform = preload("res://entities/platforms/DestructableGemsPlatform.tscn")

var level: int = 0
var current_stage: int = 0
var current_platforms_size: float

func loadFromFile(filePath: String) -> void:
	pass

func load(data, stage: int, platforms_size: float) -> Array:
	if stage > current_stage:
		current_stage = stage
		current_platforms_size = platforms_size
	return _load(data, stage)

func _load(data, stage: int) -> Array:
	var platforms = []
	match level % 4:
		0:
			platforms = _load_0_0()
		1: 
			platforms = _load_0_1()
		2:
			platforms = _load_0_2()
		3:
			platforms = _load_0_3()
		_:
			platforms = _load_0_0()
	
	level += 1
	return platforms

func _createNewPlatformInstance(gemType: int) -> Platform:
	var platform = Platform.instance()
	platform.changeGemType(gemType)
	platform.set_stage_and_level(current_stage,level)
	platform.changeGemSize(current_platforms_size)
	return platform

func _addNewPlatformToLevel(platforms: Array, positionInLevel: Vector2, gemType: int) -> void:
	var platform = _createNewPlatformInstance(gemType)
	platforms.append({ "position": positionInLevel, "platform": platform })

func _load_0_0() -> Array:
	var platforms = []
	_addNewPlatformToLevel(platforms, Vector2(520.0, 1200.0), 0)
	_addNewPlatformToLevel(platforms, Vector2(200.0, 1000.0), 0)
	_addNewPlatformToLevel(platforms, Vector2(300.0, 730.0), 0)
	_addNewPlatformToLevel(platforms, Vector2(120.0, 520.0), 0)
	_addNewPlatformToLevel(platforms, Vector2(480.0, 400.0), 0)
	_addNewPlatformToLevel(platforms, Vector2(90.0, 200.0), 0)
	_addNewPlatformToLevel(platforms, Vector2(690.0, 105.0), 0)
	_addNewPlatformToLevel(platforms, Vector2(90.0, -99.0), 0)
	_addNewPlatformToLevel(platforms, Vector2(530.0, -220.0), 0)
	_addNewPlatformToLevel(platforms, Vector2(30.0, -375.0), 0)
	return platforms

func _load_0_1() -> Array:
	var platforms = []
	_addNewPlatformToLevel(platforms, Vector2(350.0, 1200.0), 1)
	_addNewPlatformToLevel(platforms, Vector2(200.0, 1000.0), 1)
	_addNewPlatformToLevel(platforms, Vector2(300.0, 730.0), 1)
	_addNewPlatformToLevel(platforms, Vector2(120.0, 520.0), 1)
	_addNewPlatformToLevel(platforms, Vector2(480.0, 400.0), 1)
	_addNewPlatformToLevel(platforms, Vector2(90.0, 200.0), 1)
	_addNewPlatformToLevel(platforms, Vector2(690.0, 105.0), 1)
	_addNewPlatformToLevel(platforms, Vector2(90.0, -99.0), 1)
	_addNewPlatformToLevel(platforms, Vector2(320.0, -105.0), 1)
	_addNewPlatformToLevel(platforms, Vector2(120.0, -200.0), 1)
	return platforms


func _load_0_2() -> Array:
	var platforms = []
	_addNewPlatformToLevel(platforms, Vector2(350.0, 1200.0), 2)
	_addNewPlatformToLevel(platforms, Vector2(200.0, 1000.0), 2)
	_addNewPlatformToLevel(platforms, Vector2(300.0, 730.0), 2)
	_addNewPlatformToLevel(platforms, Vector2(120.0, 520.0), 2)
	_addNewPlatformToLevel(platforms, Vector2(480.0, 400.0), 2)
	_addNewPlatformToLevel(platforms, Vector2(90.0, 200.0), 2)
	_addNewPlatformToLevel(platforms, Vector2(690.0, 105.0), 2)
	_addNewPlatformToLevel(platforms, Vector2(90.0, -99.0), 2)
	_addNewPlatformToLevel(platforms, Vector2(320.0, -105.0), 2)
	_addNewPlatformToLevel(platforms, Vector2(120.0, -200.0), 2)
	return platforms

func _load_0_3() -> Array:
	var platforms = []
	_addNewPlatformToLevel(platforms, Vector2(350.0, 1200.0), 3)
	_addNewPlatformToLevel(platforms, Vector2(200.0, 1000.0), 3)
	_addNewPlatformToLevel(platforms, Vector2(300.0, 730.0), 3)
	_addNewPlatformToLevel(platforms, Vector2(120.0, 520.0), 3)
	_addNewPlatformToLevel(platforms, Vector2(480.0, 400.0), 3)
	_addNewPlatformToLevel(platforms, Vector2(90.0, 200.0), 3)
	_addNewPlatformToLevel(platforms, Vector2(690.0, 105.0), 3)
	_addNewPlatformToLevel(platforms, Vector2(90.0, -99.0), 3)
	_addNewPlatformToLevel(platforms, Vector2(320.0, -105.0), 3)
	_addNewPlatformToLevel(platforms, Vector2(120.0, -200.0), 3)
	return platforms