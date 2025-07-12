extends Node2D

const SPAWN_TIMER := 2.7
const STANDARD_WALL = preload("res://obstacle_1.tscn")
const LOCK_AND_KEY = preload("res://obstacle_2.tscn")

var elapsed_time := 0.0
var obs

func _ready() -> void:
	spawn_obstacle()

func _process(delta: float) -> void:
	elapsed_time += delta
	
	if elapsed_time >= SPAWN_TIMER:
		spawn_obstacle()

func spawn_obstacle() -> void:
	var rng = randi_range(0, 100)
	
	if rng <= 80:
		obs = STANDARD_WALL.instantiate()
		obs.position.y = randi_range(-128, 128)
		elapsed_time = 0.0
	else:
		obs = LOCK_AND_KEY.instantiate()
		elapsed_time = -2.0
	
	add_child(obs)
	
