tool
extends Node2D

class_name Level

const CURRENT_VERSION: float = 0.1
const Platform = preload("res://entities/platforms/DestructableGemsPlatform.tscn")
const NEW_PLATFORM_LOCATION = Vector2(500, 500)

var difficulty: int
var identifier: int
var level_designer_version: float
var total_num_platforms: int
var platform_configurations: Array

func _ready():
	_connectTheUI()

func getDifficulty() -> int:
	return difficulty

func getLevelIdentifier() -> int:
	return identifier

func getTotalNumberOfPlatforms() -> int:
	return total_num_platforms

func _connectTheUI() -> void:
	$LevelDesignerUI/Buttons/NewPlatform.get_popup().connect("id_pressed", self, "handleNewPlatformSelected")

func handleNewPlatformSelected(platformId: int) -> void:
	var platform = Platform.instance(platformId)
	platform.position = NEW_PLATFORM_LOCATION
	$Platforms.add_child(platform)

func handleSaveLevel() -> void:
	print("to be implemented")

func handleLoadLevel() -> void:
	print("to be implemented after save is implemented")

func handleResetLevel() -> void:
	print("to be implemented soon")