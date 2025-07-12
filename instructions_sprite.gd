extends Sprite2D

const MOUSE_NONE = preload("res://assets/Instructions/mouse.png")
const MOUSE_LEFT = preload("res://assets/Instructions/mouse_left.png")

var time_elapsed = 0.0
var timer = 0.5

func _process(delta: float) -> void:
	time_elapsed += delta
	
	if time_elapsed >= timer:
		match texture:
			MOUSE_NONE:
				texture = MOUSE_LEFT
			MOUSE_LEFT:
				texture = MOUSE_NONE
	
		time_elapsed = 0.0
