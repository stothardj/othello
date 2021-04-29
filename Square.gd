extends Area2D

signal square_picked

onready var s = get_node("Sprite")
var board_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func init(p):
	board_pos = p

func set_color(color):
	if color in ["empty", "white", "black"]:
		s.play(color)

func _on_Square_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		emit_signal("square_picked", board_pos)
		
func _on_Pieces_taken(taken_by, positions):
	if board_pos in positions:
		self.set_color(taken_by)
