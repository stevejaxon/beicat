extends ParallaxBackground

const SCROLL_END_THRESHOLD: float = 0.1

var distance_to_scroll = 0
var scroll_velocity = 0

func _process(delta):
	if distance_to_scroll > SCROLL_END_THRESHOLD:
		var scroll_this_tick = distance_to_scroll * delta * scroll_velocity
		set_scroll_offset(scroll_offset + Vector2(0, scroll_this_tick))
		distance_to_scroll = distance_to_scroll - scroll_this_tick

func characterProgressedUp(distance: int, velocity: int) -> void:
	distance_to_scroll = distance
	scroll_velocity = velocity