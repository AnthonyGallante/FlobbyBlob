extends Label

func _process(_delta: float) -> void:
	
	text = "high score\n%d" % Global.hiscore
	
	if Global.game_over:
		visible = true
		_update_hiscore()
		return
	else:
		visible = false


func _update_hiscore():
	if Global.score > Global.hiscore:
		Global.hiscore = Global.score
		print('New Hiscore! Congratulations!')
		Global.save_score(Global.hiscore)
