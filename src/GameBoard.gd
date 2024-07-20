extends GridContainer

var tiles: Array[Tile]
var tile_scene: PackedScene = load("res://Tile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	fill_board()

func fill_board():
	for i in range(0, 64):
		var tile_type: Tile.ElementType = randi_range(0, 6) as Tile.ElementType
		var tile: Tile = tile_scene.instantiate()
		tile.tile_type = tile_type
		tiles.append(tile)
		add_child(tile)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
