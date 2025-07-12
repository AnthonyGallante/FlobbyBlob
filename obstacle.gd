extends Node2D

@export var move_speed = 100

func _process(delta: float) -> void:
	position -= Vector2(move_speed, 0) * delta
	
	if global_position.x < -512:
		queue_free()
