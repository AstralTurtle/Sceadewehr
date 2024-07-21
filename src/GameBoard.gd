extends GridContainer

var tiles: Array[Array]
var tile_scene: PackedScene = load("res://Tile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	setup()
	fill_board()
	pass

func setup():
	for i in range(0, 8):
		tiles.append([])

func fill_board():
	for i in range(0, 64):
		var tile_type: Tile.ElementType = randi_range(0, 6) as Tile.ElementType
		var tile: Tile = tile_scene.instantiate()
		tile.tile_type = tile_type
		tile.side_length = size.x / 8
		tiles[i / 8].append(tile)
		add_child(tile)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
