tool
extends "res://entities/platforms/Platform.gd"

const SPRITE_RESOURCE_BASE_PATH: String = "res://assets/platforms/"
const SPRITE_RESOURCE_BASE_NAME: String = "gem_"
const SPRITE_EXTENSION: String = ".png"

var EXPLOSION_COLOR_MAP = {
	gem_type.AMETHYST: [],
	gem_type.AQUAMARINE: [],
	gem_type.EMERALD: [],
	gem_type.GARNET: [],
	gem_type.RUBY: [],
	gem_type.SAPPHIRE: []
}

export (int) var PlatformGemType = gem_type.RUBY setget changeGemType

func land() -> void:
	$platformDiamondExplosion.emitting = true
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite.visible = false

func changeGemType(newGemType: int) -> void:
	PlatformGemType = newGemType
	$Sprite.texture = load(_getGemSprite(newGemType))

func _getGemSprite(gemType: int) -> String:
	return SPRITE_RESOURCE_BASE_PATH + SPRITE_RESOURCE_BASE_NAME + String(gemType) + SPRITE_EXTENSION

func _changeExplosionColor(gemType: int) -> void:
	var colors = EXPLOSION_COLOR_MAP[gemType]

func isValidGemType(type: int) -> bool:
	if type < 0:
		return false
	match type:
		gem_type.AMETHYST:
			return true
		gem_type.AQUAMARINE:
			return true
		gem_type.EMERALD:
			return true
		gem_type.GARNET:
			return true
		gem_type.RUBY:
			return true
		gem_type.SAPPHIRE:
			return true
		_:
			return false