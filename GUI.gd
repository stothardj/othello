extends MarginContainer

onready var turn_label = $GameDivider/TopBarContainer/TurnVertical/TurnContainer/TurnLabel
onready var turn_text = $GameDivider/TopBarContainer/TurnVertical/TurnContainer/TurnText
onready var black_score_text = $GameDivider/TopBarContainer/ScoreVertical/BlackScoreContainer/BlackScoreText
onready var white_score_text = $GameDivider/TopBarContainer/ScoreVertical/WhiteScoreContainer/WhiteScoreText
onready var skip_button = $GameDivider/TopBarContainer/TurnVertical/Skip
onready var undo_button = $GameDivider/TopBarContainer/UndoButton

func _on_Board_turn_changed(turn, skippable):
	undo_button.visible = true
	turn_text.text = turn
	var color = Color(1, 1, 1) if turn == "white" else Color(0, 0, 0)
	turn_label.add_color_override("font_color", color)
	turn_text.add_color_override("font_color", color)
	skip_button.visible = skippable

func _on_Board_pieces_taken(_taken_by, _positions, scores):
	black_score_text.text = str(scores['black_count'])
	white_score_text.text = str(scores['white_count'])

func _on_WinContainer_new_game():
	undo_button.visible = false
	black_score_text.text = "2"
	white_score_text.text = "2"

func _on_Board_undo(can_undo_again, scores):
	undo_button.visible = can_undo_again
	black_score_text.text = str(scores['black_count'])
	white_score_text.text = str(scores['white_count'])
