extends Node

class_name LevelLoader

const Platform = preload("res://entities/platforms/DestructableGemsPlatform.tscn")

static func loadFromFile(filePath: String) -> void:
	pass

static func load(data) -> Array:
	return _load(data)

static func _load(data) -> Array:
	var platforms = []
	var platform = Platform.instance()
	platform.changeGemType(0)
	platforms.append({ "position": Vector2(30.0, 1200.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(1)
	platforms.append({ "position": Vector2(200.0, 1000.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(2)
	platforms.append({ "position": Vector2(300.0, 730.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(0)
	platforms.append({ "position": Vector2(120.0, 520.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(3)
	platforms.append({ "position": Vector2(480.0, 400.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(4)
	platforms.append({ "position": Vector2(90.0, 200.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(5)
	platforms.append({ "position": Vector2(690.0, 105.0), "platform": platform })
	return platforms