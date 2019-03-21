extends "res://entities/platforms/Platform.gd"

func land() -> void:
	$CollisionShape2D.disabled = true
	$Sprite.visible = true
	$platformDiamondExplosion.emitting = true