extends MarginContainer


# TODO, move this logic to TopBarContainer or something
onready var turn_label = $GameDivider/TopBarContainer/TurnVertical/TurnContainer/TurnLabel
onready var turn_text = $GameDivider/TopBarContainer/TurnVertical/TurnContainer/TurnText
onready var black_score_text = $GameDivider/TopBarContainer/ScoreVertical/BlackScoreContainer/BlackScoreText
onready var white_score_text = $GameDivider/TopBarContainer/ScoreVertical/WhiteScoreContainer/WhiteScoreText


func _on_Board_turn_changed(turn):
	turn_text.text = turn
	var color = Color(1, 1, 1) if turn == "white" else Color(0, 0, 0)
	turn_label.add_color_override("font_color", color)
	turn_text.add_color_override("font_color", color)


func _on_Board_game_over(scores):
	print("Winner: {winner}  White: {white_count}  Black: {black_count}".format(scores))


func _on_Board_pieces_taken(taken_by, positions, scores):
	black_score_text.text = str(scores['black_count'])
	white_score_text.text = str(scores['white_count'])
