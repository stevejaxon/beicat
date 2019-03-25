extends Node

class_name PlatformConfigurations

var platform_type: int
var platform_position: Vector2
var platform_index: int
var last_platform: bool

func _init(type: int, position: Vector2, index: int, last: bool = false):
	platform_type = type
	platform_position = position
	platform_index =  index
	last_platform = last

func getPlatformType() -> int:
	return platform_type

func getPlatformPosition() -> Vector2:
	return platform_position

func getPlatformIndex() -> int:
	return platform_index

func isLastPlatform() -> bool:
	return last_platform