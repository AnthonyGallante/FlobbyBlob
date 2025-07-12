extends Button

func _process(_delta: float) -> void:
	if Global.game_over:
		visible = true
	else:
		visible = false
