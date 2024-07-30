extends TextureRect
class_name Tile

@export var tile_type: ElementType
var side_length: float = 50

var grid_index: Vector2i

signal tile_selected(Vector2i)

var to_clear: bool = false

@onready var test: Texture = load('res://icon.svg')

# set in editor
@export var tile_images = {
	ElementType.AIR: load('res://assets/Air.png'),
	ElementType.WATER: load('res://assets/Water.png'),
	ElementType.FIRE: load('res://assets/Fire.png'),
	ElementType.EARTH: load('res://assets/Earth.png'),
	ElementType.BODY: load('res://assets/Body.png'),
	ElementType.SOUL: load('res://assets/Soul.png'),
	ElementType.MERCURY: load('res://assets/Mercury.png'),
	ElementType.DISABLED: test
}

enum ElementType {
	# The elements
	AIR, WATER, FIRE, EARTH,
	# The primes
	BODY, SOUL, MERCURY, DISABLED
}

func _gui_input(event):
	if event is InputEventMouseButton && event.is_released():
		emit_signal('tile_selected', grid_index)

func _ready():
	texture = tile_images[tile_type]
	
	custom_minimum_size.x = side_length
	custom_minimum_size.y = side_length

func set_focused(b: bool):
	print(grid_index)
	get_node('f1').visible = b
	get_node('f2').visible = b
	get_node('f3').visible = b
	get_node('f4').visible = b
	
func set_grid_index(new_index: Vector2i):
	grid_index = new_index


func scramble():
	var new_type: ElementType = tile_type
	while tile_type == new_type:
		new_type = randi_range(0, 6) as ElementType
	tile_type = new_type
	# if (tile)
	texture = tile_images[tile_type]