extends CenterContainer

onready var winner_announce = $Panel/VBox/WinnerAnnounce
onready var final_score = $Panel/VBox/FinalScore

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
	final_score.text = '%s - %s' % [win_score, lose_score]
	self.visible = true
