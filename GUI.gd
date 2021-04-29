extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var turn_label = $TopBarContainer/TurnVertical/TurnContainer/TurnLabel
onready var turn_text = $TopBarContainer/TurnVertical/TurnContainer/TurnText
onready var black_score_text = $TopBarContainer/ScoreVertical/BlackScoreContainer/BlackScoreText
onready var white_score_text = $TopBarContainer/ScoreVertical/WhiteScoreContainer/WhiteScoreText

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


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
