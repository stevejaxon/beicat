extends "res://entities/platforms/Platform.gd"

func land() -> void:
	$platformDiamondExplosion.emitting = true
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite.visible = false