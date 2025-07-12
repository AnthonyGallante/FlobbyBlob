extends Node2D

@onready var background_music: AudioStreamPlayer2D = $BackgroundMusic


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
	Global.music_position = background_music.get_playback_position()


func _ready() -> void:
	background_music.play(0)
