extends ParallaxBackground

func characterProgressedUp(distance: int, velocity: int) -> void:
	# The character broadcasts the height it has jumped up and we want the background to scroll down (-ve in the Y axis)
	set_scroll_offset(Vector2(0, -distance))