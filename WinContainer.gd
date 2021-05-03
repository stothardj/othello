extends CenterContainer

onready var winner_announce = $Panel/VBox/WinnerAnnounce
onready var final_score = $Panel/VBox/FinalScore

signal new_game

func _on_Board_game_over(scores):
	winner_announce.text = "Winner: {winner}".format(scores)
	var win_score = 0
	var lose_score = 0
	var color = Color(0,0,0)
	if scores['winner'] == 'white':
		win_score = scores['white_count']
		lose_score = scores['black_count']
		color = Color(1,1,1)
	else:
		win_score = scores['black_count']
		lose_score = scores['white_count']
	winner_announce.add_color_override("font_color", color)
	final_score.add_color_override("font_color", color)
	final_score.text = '%s - %s' % [win_score, lose_score]
	self.visible = true

func _on_NewGame_pressed():
	self.visible = false
	emit_signal("new_game")
