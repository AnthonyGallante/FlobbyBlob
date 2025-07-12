extends Node

var game_over = false
var playing = false
var score

var music_position: float = 0.0

var file_path = "user://hiscore.save"
var hiscore: int

func load_score():
	if FileAccess.file_exists(file_path):
		print('Loading in previous hiscore data.')
		var file = FileAccess.open(file_path, FileAccess.READ)
		hiscore = file.get_var()

		# RESET SCORE!
		#hiscore = 0
		#save_score(hiscore)
		
		file.close()
		prints('Looks like your highest score is', hiscore, 'Good Luck!')
	else:
		print('No previous hiscore data. Creating a new save file.')
		hiscore = 0
		save_score(hiscore)

func save_score(new_hiscore):
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_var(new_hiscore)
	prints('New Hiscore!', new_hiscore)

func _ready() -> void:
	load_score()
