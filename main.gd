extends Node2D

@onready var background_music: AudioStreamPlayer2D = $Audio/BackgroundMusic

func _on_play_again_button_pressed() -> void:
	get_tree().reload_current_scene()
	Global.game_over = false
	Global.playing = true
	Global.music_position = background_music.get_playback_position()

func _ready() -> void:
	Global.score = 0
	background_music.play(Global.music_position)

	if Global.hiscore > 5:
		$Instructions.visible = false
	else:
		await get_tree().create_timer(4.0).timeout
		$Instructions.visible = false


func _process(_delta: float) -> void:
	if Global.game_over:
		$Instructions.visible = false
