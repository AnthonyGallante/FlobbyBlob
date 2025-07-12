extends Node2D

@export var layer_1_movement_speed: int = 0
@export var layer_2_movement_speed: int = 25
@export var layer_3_movement_speed: int = 50
@export var layer_4_movement_speed: int = 100

@onready var layer_1: Node2D = $Layer1
@onready var layer_2: Node2D = $Layer2
@onready var layer_3: Node2D = $Layer3
@onready var layer_4: Node2D = $Layer4


func _process(delta: float) -> void:
	for layer in [layer_2, layer_3, layer_4]:
		move_layer(layer, delta)
		reset_layer(layer)


func move_layer(layer, delta):
	match layer:
		layer_2:
			layer.position -= Vector2(layer_2_movement_speed, 0) * delta
		layer_3:
			layer.position -= Vector2(layer_3_movement_speed, 0) * delta
		layer_4:
			layer.position -= Vector2(layer_4_movement_speed, 0) * delta
		_:
			layer.position -= Vector2.ZERO


func reset_layer(layer):
	if layer.position.x <= -2048:
		layer.position.x = 0
