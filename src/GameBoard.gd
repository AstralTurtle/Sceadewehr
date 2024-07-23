extends GridContainer

@export var swap_anim_time: float = 1
var tiles: Array[Array]
var tile_scene: PackedScene = load("res://Tile.tscn")
var locked: bool = false

var selected_tile = null

# Called when the node enters the scene tree for the first time.
func _ready():
	setup()
	fill_board()
	pass

func on_tile_clicked(pos: Vector2i):
	if locked:
		return
	print(pos)

	# The tweens
	# var tween = get_tree().create_tween()
	# tween.set_parallel(true)

	if selected_tile == null:
		selected_tile = pos
		tiles[selected_tile.y][selected_tile.x].set_focused(true)
	elif (selected_tile as Vector2).distance_to(pos as Vector2) < 1.5:
		print((selected_tile as Vector2).distance_to(pos as Vector2))
		var selected: Tile = tiles[selected_tile.y][selected_tile.x]
		var new_selection: Tile = tiles[pos.y][pos.x]
		# tween.tween_property(selected, "position", pos, swap_anim_time)
		# tween.tween_property(new_selection, "position", selected_tile, swap_anim_time)
		move_child(selected, new_selection.get_index())
		move_child(new_selection, selected.get_index())
		selected.set_grid_index(pos)
		new_selection.set_grid_index(selected_tile)
		tiles[selected_tile.y][selected_tile.x] = new_selection
		tiles[pos.y][pos.x] = selected
		selected.set_focused(false)
		selected_tile = null
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
		tile.pos = Vector2i(i % 8, i / 8)
		tile.connect('tile_selected', on_tile_clicked)
		tiles[i / 8].append(tile)
		add_child(tile)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
