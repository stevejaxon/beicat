extends Node

class_name LevelLoader

const Platform = preload("res://entities/platforms/DestructableGemsPlatform.tscn")

var level: int = 0
var current_stage = 0

func loadFromFile(filePath: String) -> void:
	pass

func load(data, stage: int) -> Array:
	if stage > current_stage:
		current_stage = stage
		level = 0
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

func _load_0_0() -> Array:
	var platforms = []
	var platform = Platform.instance()
	platform.changeGemType(0)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(350.0, 1200.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(0)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(200.0, 1000.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(0)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(300.0, 730.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(0)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(120.0, 520.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(0)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(480.0, 400.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(0)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(90.0, 200.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(0)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(690.0, 105.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(0)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(90.0, -99.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(0)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(320.0, -105.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(0)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(530.0, -220.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(0)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(30.0, -375.0), "platform": platform })
	return platforms

func _load_0_1() -> Array:
	var platforms = []
	var platform = Platform.instance()
	platform.changeGemType(1)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(350.0, 1200.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(1)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(200.0, 1000.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(1)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(300.0, 730.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(1)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(120.0, 520.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(1)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(480.0, 400.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(1)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(90.0, 200.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(1)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(690.0, 105.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(1)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(90.0, -99.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(1)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(320.0, -105.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(1)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(120.0, -200.0), "platform": platform })
	return platforms


func _load_0_2() -> Array:
	var platforms = []
	var platform = Platform.instance()
	platform.changeGemType(2)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(350.0, 1200.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(2)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(200.0, 1000.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(2)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(300.0, 730.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(2)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(120.0, 520.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(2)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(480.0, 400.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(2)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(90.0, 200.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(2)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(690.0, 105.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(2)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(90.0, -99.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(2)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(320.0, -105.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(2)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(120.0, -200.0), "platform": platform })
	return platforms

func _load_0_3() -> Array:
	var platforms = []
	var platform = Platform.instance()
	platform.changeGemType(3)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(350.0, 1200.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(3)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(200.0, 1000.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(3)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(300.0, 730.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(3)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(120.0, 520.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(3)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(480.0, 400.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(3)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(90.0, 200.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(3)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(690.0, 105.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(3)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(90.0, -99.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(3)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(320.0, -105.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(3)
	platform.set_stage_and_level(0,level)
	platforms.append({ "position": Vector2(120.0, -200.0), "platform": platform })
	return platforms