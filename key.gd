extends StaticBody2D

func _ready() -> void:
	position = Vector2(0, randf_range(-200, 200))

var time_elapsed := 0.0
var bob_time := 1.5
var overflow_counter := 0
var _sign := 1

func _process(delta: float) -> void:
	
	time_elapsed += delta
	
	if time_elapsed > bob_time:
		overflow_counter += 1
		time_elapsed = 0.0
	
	if overflow_counter % 2 == 0:
		_sign = -1
	else:
		_sign = 1
	
	position += Vector2(0, 3 * _sign * delta)
