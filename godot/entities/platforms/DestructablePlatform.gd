tool
extends "res://entities/platforms/Platform.gd"

const SPRITE_RESOURCE_BASE_PATH: String = "res://assets/platforms/"
const SPRITE_RESOURCE_BASE_NAME: String = "gem_"
const SPRITE_EXTENSION: String = ".png"
const GEMS_LARGEST_TRANSFORM_SIZE: float = 0.3
const GEMS_SMALLEST_TRANSFORM_SIZE: float = 0.05

var EXPLOSION_COLOR_MAP = {
	gem_type.AMETHYST: ["#b427f1", "#ffa8ec"],
	gem_type.AQUAMARINE: ["#00cbf7", "#00f8f3"],
	gem_type.EMERALD: ["#5cc15a", "#bfffa6"],
	gem_type.GARNET: ["#ff9035", "#ffcb73"],
	gem_type.RUBY: ["#ff6e71", "#ffc0a0"],
	gem_type.SAPPHIRE: ["#1d60ff", "#00dff5"]
}

export (int) var PlatformGemType = gem_type.RUBY setget changeGemType

func land() -> void:
	.land()
	$platformDiamondExplosion.emitting = true
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite.visible = false

func changeGemType(newGemType: int) -> void:
	PlatformGemType = newGemType
	$Sprite.texture = load(_getGemSprite(newGemType))
	_changeExplosionColor(newGemType)

# The size is the relative to the original sprite's size (which is currently very large)
# newSize updates both the Sprite and CollisionShape2D's transform's scale (x and y) property.
func changeGemSize(newSize: float) -> void:
	if newSize <= GEMS_LARGEST_TRANSFORM_SIZE and newSize >= GEMS_SMALLEST_TRANSFORM_SIZE:
		var newScale = Vector2(newSize, newSize)
		$Sprite.set_scale(newScale)
		$CollisionShape2D.set_scale(newScale)

func _getGemSprite(gemType: int) -> String:
	return SPRITE_RESOURCE_BASE_PATH + SPRITE_RESOURCE_BASE_NAME + String(gemType) + SPRITE_EXTENSION

func _changeExplosionColor(gemType: int) -> void:
	var colors = EXPLOSION_COLOR_MAP[gemType]
	var gradient = Gradient.new()
	gradient.set_offsets(PoolRealArray([0.225, 1]))
	gradient.set_colors(PoolColorArray(colors))
	$platformDiamondExplosion.color_ramp = gradient

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