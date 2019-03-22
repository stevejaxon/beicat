extends Area2D

const SCROLL_END_THRESHOLD: float = 0.1

var scroll_distance = 0
var scroll_velocity = 0

class_name Platform

func _process(delta):
	if scroll_distance > SCROLL_END_THRESHOLD:
		var move_this_tick = scroll_distance * delta * scroll_velocity
		move_local_y(move_this_tick)
		scroll_distance = scroll_distance - move_this_tick
	elif scroll_distance > 0 and scroll_distance < SCROLL_END_THRESHOLD:
		scroll_distance = 0

func scrollDown(distance: int, velocity: int) -> void:
	scroll_distance = distance
	scroll_velocity = velocity

func leftScreen(area: Area2D) -> void:
	#free()
	pass

func land() -> void:
	pass