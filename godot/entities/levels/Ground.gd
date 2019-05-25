extends Node2D

func freeGroundFromGame() -> void:
	for tile in get_children():
		tile.call_deferred("queue_free")