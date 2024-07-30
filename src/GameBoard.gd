extends GridContainer
class_name GameBoard

@export var swap_anim_time: float = 0.5
@export var clear_anim_time: float = 0.1
var tiles: Array[Array]
var tile_scene: PackedScene = load("res://Tile.tscn")
var ingridients: Array[Tile.ElementType] = []
var locked: bool = false
@onready var slide_sfx: AudioStreamPlayer = get_tree().root.get_node("MainWorld/SlideSFX")

var selected_tile = null

signal swap_complete()

# Called when the node enters the scene tree for the first time.
func _ready():
	setup()
	fill_board()

func on_tile_clicked(pos: Vector2i):
	if locked:
		return


	if selected_tile == null:
		selected_tile = pos
		tiles[selected_tile.y][selected_tile.x].set_focused(true)
	elif (selected_tile as Vector2).distance_to(pos as Vector2) < 1.5 and (selected_tile as Vector2).distance_to(pos as Vector2) > 0:
		slide_sfx.play()
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
			await clear_board(tiles)
			emit_signal(swap_complete.get_name())

		selected.set_focused(false)
		tween.connect("finished", cleanup)
	else:
	
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
	await delete_tiles()
	if (!clean_board()):
		return await clear_board(board)
	return true

func clear_horizontal(board: Array[Array]):
	for y in range(board.size()):
		var consecutive: Array[Tile] = []
		var lastType = -1
		for x in range(board[0].size()):

			if ((board[y][x] as Tile).tile_type != lastType):
				if (consecutive.size() >= 3):
					for i in range(consecutive.size() - 2):
						ingridients.append(consecutive[0].tile_type)
					for t: Tile in consecutive:
						t.to_clear = true
						consecutive = []
				else:
					consecutive = []
			lastType = (board[y][x] as Tile).tile_type
			consecutive.append(board[y][x] as Tile)
		if (consecutive.size() >= 3):
			for i in range(consecutive.size() - 2):
				ingridients.append(consecutive[0].tile_type)
			for t: Tile in consecutive:
				t.to_clear = true

func clear_vertical(board: Array[Array]):
	for x in range(board[0].size()):
		var consecutive: Array[Tile] = []
		var lastType = -1
		for y in range(board.size()):
			if ((board[y][x] as Tile).tile_type != lastType):
				if (consecutive.size() >= 3):
					for i in range(consecutive.size() - 2):
						ingridients.append(consecutive[0].tile_type)
					for t: Tile in consecutive:
						t.to_clear = true
						consecutive = []
				else:
					consecutive = []
			lastType = (board[y][x] as Tile).tile_type
			consecutive.append(board[y][x] as Tile)
		if (consecutive.size() >= 3):
			for i in range(consecutive.size() - 2):
				ingridients.append(consecutive[0].tile_type)
			for t: Tile in consecutive:
				t.to_clear = true

func delete_tiles():
	for t: Tile in get_children():
		if (t.to_clear):
			await delete_tile(t.grid_index)

func clean_board():
	var clean: bool = true
	for t: Tile in get_children():
		if (t.to_clear):
			clean = false
			t.to_clear = false
	return clean
func delete_tile(idx: Vector2i):
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
		var bellow: Tile = tiles[r + 1][idx.x]
		# Fix the position
		tween.tween_property(current, "position", bellow.position, clear_anim_time)
		r += 1;
	dead_one.scramble()
	dead_one.position = top_pos
	dead_one.position.y -= 300
	tween.tween_property(dead_one, "position", top_pos, clear_anim_time)
	await tween.finished
	
	r = idx.y
	while r > 0:
		r -= 1
		var current: Tile = tiles[r][idx.x]
		var bellow: Tile = tiles[r + 1][idx.x]
		tiles[r][idx.x] = bellow
		bellow.grid_index = Vector2(idx.x, r)
		tiles[r + 1][idx.x] = current
		current.grid_index = Vector2(idx.x, r + 1)
		var bellow_idx = bellow.get_index()
		move_child(bellow, current.get_index())
		move_child(current, bellow_idx)
	
func dump_ingridients() -> Array[Tile.ElementType]:
	var ing = ingridients.duplicate()
	ingridients.clear()
	return ing