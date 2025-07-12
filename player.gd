extends CharacterBody2D

const GRAVITY: float = 500.0
const JUMP_FORCE: float = -250.0

@onready var player_area: Area2D = $PlayerArea
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

@onready var player_sprite: Sprite2D = $Sprite2D
const PLAYER_GREEN_ROLL = preload("res://assets/Player/playerGreen_roll.png")
const PLAYER_GREEN_UP_1 = preload("res://assets/Player/playerGreen_up1.png")
const PLAYER_GREEN_UP_2 = preload("res://assets/Player/playerGreen_up2.png")
const PLAYER_GREEN_UP_3 = preload("res://assets/Player/playerGreen_up3.png")
const PLAYER_GREEN_FALL = preload("res://assets/Player/playerGreen_fall.png")
const PLAYER_GREEN_DEAD = preload("res://assets/Player/playerGreen_dead.png")


@onready var jump_audio: AudioStreamPlayer2D = $"../Audio/JumpAudio"
@onready var game_over_audio: AudioStreamPlayer2D = $"../Audio/GameOverAudio"
@onready var fall_audio: AudioStreamPlayer2D = $"../Audio/FallAudio"
@onready var hurt_audio: AudioStreamPlayer2D = $"../Audio/HurtAudio"
@onready var collect_item: AudioStreamPlayer2D = $"../Audio/CollectItem"
@onready var point_awarded: AudioStreamPlayer2D = $"../Audio/PointAwarded"
@onready var tenth_point: AudioStreamPlayer2D = $"../Audio/10thPoint"

var alive: bool

func _ready() -> void:
	alive = true

func _process(delta: float) -> void:
	move_and_slide()
	apply_gravity(delta)
	
	if alive:
		react_to_jump()
		adjust_sprite()
		check_bounds()


func check_bounds():
	if global_position.y < 0 or global_position.y > 512:
		_die()

func react_to_jump():
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_FORCE
		play_adjusted_sound(jump_audio)


func play_adjusted_sound(audio: AudioStreamPlayer2D):
		var rng = randf_range(0.9, 1.0)
		audio.pitch_scale = rng
		audio.play()


func adjust_sprite():
	if velocity.y <= 0:
		player_sprite.texture = PLAYER_GREEN_UP_1
	elif velocity.y < 150:
		player_sprite.texture = PLAYER_GREEN_UP_2
	elif velocity.y < 300:
		player_sprite.texture = PLAYER_GREEN_UP_3
	else:
		player_sprite.texture = PLAYER_GREEN_FALL


func apply_gravity(delta):
	velocity.y += clamp(GRAVITY * delta, -1000, 3000)


func _on_player_area_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("Item"):
		body.queue_free()
		body.get_parent().find_child("Lock").queue_free()
		play_adjusted_sound(collect_item)
	
	if body.is_in_group("Killzone"):
		print("GAME OVER!!")
		play_adjusted_sound(hurt_audio)
		_die()


func _die():
	alive = false
	collision_shape.queue_free()
	player_area.queue_free()
	velocity = Vector2(randf_range(100, 200), randf_range(-100, -200))
	player_sprite.texture = PLAYER_GREEN_DEAD
	play_adjusted_sound(fall_audio)
	$Emote.visible = false
	
	await get_tree().create_timer(1.0).timeout
	play_adjusted_sound(game_over_audio)
	
	Global.game_over = true
	Global.playing = false


func _on_player_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("ScoreZone"):
		Global.score += 1
		area.queue_free()
		play_adjusted_sound(point_awarded)
	
	if Global.score % 10 == 0 and Global.score > 1:
		$Emote.visible = true
		play_adjusted_sound(tenth_point)
		await get_tree().create_timer(1.5).timeout
		$Emote.visible = false
	else:
		$Emote.visible = false
	
	
