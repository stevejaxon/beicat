extends Position2D

var Platform = preload("res://entities/platforms/Platform.tscn")

signal new_platform(platform)

export var enabled: bool = true
export var spawn_probibility: float = 1.0

func _ready():
	randomize()

func instance(distance: int, velocity: int):
	if not enabled:
		return
	var platformInstance = Platform.instance()
	platformInstance.position = position
	emit_signal("new_platform", platformInstance)