extends Area2D

signal square_picked

onready var s = $Sprite
var board_pos

func init(p):
	board_pos = p

func set_color(color):
	if color in ["empty", "white", "black"]:
		s.play(color)

func set_size(size):
	var image_size = $Sprite.frames.get_frame("empty", 0).get_size()
	var scale = Vector2(size / image_size.x, size / image_size.y)
	$Sprite.scale = scale

func _on_Square_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		emit_signal("square_picked", board_pos)
	elif event is InputEventScreenTouch:
		emit_signal("square_picked", board_pos)

func _on_Pieces_taken(taken_by, positions, _scores):
	if board_pos in positions:
		self.set_color(taken_by)
