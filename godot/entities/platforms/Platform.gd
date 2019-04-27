extends Area2D

class_name Platform

func land() -> void:
	call_deferred('free')