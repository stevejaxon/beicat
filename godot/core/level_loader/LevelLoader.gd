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
	platforms.append({ "position": Vector2(80.0, 1200.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(1)
	platforms.append({ "position": Vector2(180.0, 1000.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(2)
	platforms.append({ "position": Vector2(280.0, 800.0), "platform": platform })
	platform = Platform.instance()
	platform.changeGemType(3)
	platforms.append({ "position": Vector2(380.0, 600.0), "platform": platform })
	return platforms