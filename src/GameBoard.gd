extends GridContainer
class_name GameBoard

@export var swap_anim_time: float = 0.5
var tiles: Array[Array]
var tile_scene: PackedScene = load("res://Tile.tscn")
var locked: bool = false

var selected_tile = null

# Called when the node enters the scene tree for the first time.
func _ready():
	setup()
	fill_board()

func on_tile_clicked(pos: Vector2i):
	if locked:
		return
	print(pos)

	if selected_tile == null:
		selected_tile = pos
		tiles[selected_tile.y][selected_tile.x].set_focused(true)
	elif (selected_tile as Vector2).distance_to(pos as Vector2) < 1.5:
		print((selected_tile as Vector2).distance_to(pos as Vector2))
		var selected: Tile = tiles[selected_tile.y][selected_tile.x]
		var new_selection: Tile = tiles[pos.y][pos.x]
		var selected_index = selected.get_index()
		var old_selection_pos = selected.position

		# The tweens
		var tween = get_tree().create_tween()
		tween.set_parallel(true)
		# tween.set_trans(Tween.TRANS_ELASTIC) # Too funny
		tween.set_trans(Tween.TRANS_EXPO)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(selected, "position", new_selection.position, swap_anim_time)
		tween.tween_property(new_selection, "position", old_selection_pos, swap_anim_time)
		locked = true

		var cleanup = func():
			move_child(selected, new_selection.get_index())
			move_child(new_selection, selected_index)
			selected.set_grid_index(pos)
			new_selection.set_grid_index(selected_tile)
			tiles[selected_tile.y][selected_tile.x] = new_selection
			tiles[pos.y][pos.x] = selected
			selected_tile = null
			locked = false
			clear_board(tiles)

		selected.set_focused(false)
		tween.connect("finished", cleanup)
	else:
		print((selected_tile as Vector2).distance_to(pos as Vector2))
		tiles[selected_tile.y][selected_tile.x].set_focused(false)
		selected_tile = null

func setup():
	for i in range(0, 8):
		tiles.append([])

func fill_board():
	for i in range(0, 64):
		var tile_type: Tile.ElementType = randi_range(0, 6) as Tile.ElementType
		var tile: Tile = tile_scene.instantiate()
		tile.tile_type = tile_type
		tile.side_length = size.x / 8
		tile.grid_index = Vector2i(i % 8, i / 8)
		tile.connect('tile_selected', on_tile_clicked)
		tiles[i / 8].append(tile)
		add_child(tile)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func convert_to_flat(arr: Array[Array]):
	var ret = []
	for i in range(arr.size()):
		ret.append_array(arr[i])
	return ret

func clear_board(board: Array[Array]):
	clear_horizontal(board)
	clear_vertical(board)

func clear_horizontal(board: Array[Array]):
	for y in range(board.size()):
		var consecutive: Array[Tile] = []
		var lastType = -1
		for x in range(board[0].size()):
			print(y, ' ', x, ' ', lastType)
			if ((board[y][x] as Tile).tile_type != lastType):
				if (consecutive.size() >= 3):
					for t: Tile in consecutive:
						t.to_clear = true
						print('index: ', t.grid_index)
						consecutive = []
				else:
					consecutive = []
			lastType = (board[y][x] as Tile).tile_type
			consecutive.append(board[y][x] as Tile)
		if (consecutive.size() >= 3):
			for t: Tile in consecutive:
				t.to_clear = true

func clear_vertical(board: Array[Array]):
	for x in range(board[0].size()):
		var consecutive: Array[Tile] = []
		var lastType = -1
		for y in range(board.size()):
			print(y, ' ', x, ' ', lastType)
			if ((board[y][x] as Tile).tile_type != lastType):
				if (consecutive.size() >= 3):
					for t: Tile in consecutive:
						t.to_clear = true
						print('index: ', t.grid_index)
						consecutive = []
				else:
					consecutive = []
			lastType = (board[y][x] as Tile).tile_type
			consecutive.append(board[y][x] as Tile)
		if (consecutive.size() >= 3):
			for t: Tile in consecutive:
				t.to_clear = true

func delete_tiles():
	for t: Tile in get_children():
		if (t.to_clear):
			t.queue_free()

func delete_tile(idx: Vector2i):
	locked = true
	# Tween
	var tween: Tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_OUT)
	
	# Tile to be re_made
	var r = 0
	var dead_one: Tile = tiles[idx.y][idx.x]
	var top_pos: Vector2 = tiles[0][idx.x].position
	
	# Loop it
	while r < idx.y:
		var current: Tile = tiles[r][idx.x]
		var bellow: Tile = tiles[r+1][idx.x]
		# Fix the position
		tween.tween_property(current, "position", bellow.position, swap_anim_time)
		r += 1;
	dead_one.scramble()
	dead_one.position = top_pos
	dead_one.position.y -= 300
	tween.tween_property(dead_one, "position", top_pos, swap_anim_time+0.5)
	await tween.finished
	
	r = idx.y
	while r > 0:
		r -= 1
		var current: Tile = tiles[r][idx.x]
		var bellow: Tile = tiles[r+1][idx.x]
		tiles[r][idx.x] = bellow
		bellow.grid_index = Vector2(idx.x, r)
		tiles[r+1][idx.x] = current
		current.grid_index = Vector2(idx.x, r+1)
		var bellow_idx = bellow.get_index()
		move_child(bellow, current.get_index())
		move_child(current, bellow_idx)
	locked = false
		


	
func tween_tile_hack(tile: Tile, global_pos: Vector2, final_pos: Vector2, tween: Tween):
	var fake_tile = Tile.new()
	fake_tile.tile_type = tile.tile_type
	fake_tile.side_length = tile.side_length
	get_parent().add_child(fake_tile)
	tween.connect("finished", func(): fake_tile.queue_free())
	fake_tile.global_position = global_pos
	tween.tween_property(fake_tile, "global_position", final_pos, swap_anim_time)

