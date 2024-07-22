extends GridContainer

var tiles: Array[Array]
var tile_scene: PackedScene = load("res://Tile.tscn")

var selected_tile = null

# Called when the node enters the scene tree for the first time.
func _ready():
	setup()
	fill_board()
	pass

func on_tile_clicked(pos: Vector2):
	print(pos)
	if selected_tile == null:
		selected_tile = pos
		tiles[selected_tile.y][selected_tile.x].set_focused(true)
	elif selected_tile.distance_to(pos) < 1.5:
		print(selected_tile.distance_to(pos))
		var selected: Tile = tiles[selected_tile.y][selected_tile.x]
		var new_selection: Tile = tiles[pos.y][pos.x]
		var selected_in = selected.get_index()
		move_child(selected, new_selection.get_index())
		move_child(new_selection, selected_in)
		selected.set_pos(pos)
		new_selection.set_pos(selected_tile)
		tiles[selected_tile.y][selected_tile.x] = new_selection
		tiles[pos.y][pos.x] = selected
		selected.set_focused(false)
		selected_tile = null
	else:
		print(selected_tile.distance_to(pos))
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
		tile.pos = Vector2(i % 8, i / 8)
		tile.connect('tile_selected', on_tile_clicked)
		tiles[i / 8].append(tile)
		add_child(tile)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
