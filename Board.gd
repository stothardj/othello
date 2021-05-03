extends MarginContainer

signal pieces_taken
signal turn_changed
signal game_over

var square = preload("res://Square.tscn")
var turn = "black"
var board = {}
var children = {}
var all_positions = []
var neighbor_directions = []

func positions_taken(on_turn, pos):
	var positions = []
	if pos in board:
		return positions
	
	for neighbor_direction in neighbor_directions:
		var p = pos + neighbor_direction
		if not p in board:
			continue
		var neighbor_color = board[p]
		if neighbor_color == on_turn:
			continue
		var search_pos = p
		var search_color = neighbor_color
		while search_color == neighbor_color:
			search_pos += neighbor_direction
			search_color = board.get(search_pos, "empty")
		if search_color == on_turn:
			while p != search_pos:
				positions.append(p)
				p += neighbor_direction
			
	return positions

func next_turn():
	if turn != "black":
		return "black"
	else:
		return "white"

func get_scores():
	var white_count = 0
	var black_count = 0
	for p in board.keys():
		var color = board[p]
		if color == "white":
			white_count += 1
		else:
			black_count += 1
	var winner = "tie"
	if white_count > black_count:
		winner = "white"
	elif black_count > white_count:
		winner = "black"
	return {
		"white_count": white_count,
		"black_count": black_count,
		"winner": winner
	}

func _on_Square_picked(pos):
	var ps = positions_taken(turn, pos)
	if not ps.empty():
		ps.append(pos)
		for p in ps:
			board[p] = turn
		var scores = get_scores()
		emit_signal("pieces_taken", turn, ps, scores)
		var next_can_go = can_go(next_turn())
		if not can_go(turn) and not next_can_go:
			emit_signal("game_over", scores)
		else:
			turn = next_turn()
			emit_signal("turn_changed", turn, !next_can_go)

# Called when the node enters the scene tree for the first time.
func _ready():	
	for i in range(-1, 2):
		for j in range(-1, 2):
			if i or j:
				neighbor_directions.append(Vector2(i,j))
	
	for r in range(0,8):
		for c in range(0,8):
			all_positions.append(Vector2(r, c))
	
	var board_width = self.rect_size.x
	var board_height = self.rect_size.y
	var board_size = min(board_width, board_height)
	var piece_size = board_size / 8
	var piece_offset = piece_size / 2
	var board_shift = Vector2(
		(board_width - board_size) / 2 + piece_offset,
		(board_height - board_size) / 2 + piece_offset)
	for p in all_positions:
		var sq = square.instance()
		sq.init(p)
		sq.position = Vector2(p[1],p[0]) * piece_size + board_shift
		add_child(sq)
		children[p] = sq
		sq.set_size(piece_size)
		sq.connect("square_picked", self, "_on_Square_picked")
		self.connect("pieces_taken", sq, "_on_Pieces_taken")

	start_board()	


func can_go(on_turn):
	for p in all_positions:
		if not positions_taken(on_turn, p).empty():
			return true
	return false

func _on_Skip_pressed():
	if not can_go(turn):
		turn = next_turn()
		emit_signal("turn_changed", turn, false)

func clear_board():
	for pos in all_positions:
		children[pos].set_color("empty")
		
func start_board():
	board = {
		Vector2(3,3): "white",
		Vector2(4,4): "white",
		Vector2(3,4): "black",
		Vector2(4,3): "black"
	}
	for pos in board.keys():
		children[pos].set_color(board[pos])

func _on_WinContainer_new_game():
	clear_board()
	start_board()
