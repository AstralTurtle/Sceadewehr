extends TextureRect
class_name Tile

@export var tile_type: ElementType
var side_length: float = 50

# set in editor
@export var tile_images = [
 preload ('res://assets/Air.png'),
 preload ('res://assets/Water.png'),
 preload ('res://assets/Fire.png'),
 preload ('res://assets/Earth.png'),
 preload ('res://assets/Body.png'),
 preload ('res://assets/Soul.png'),
 preload ('res://assets/Mercury.png')
]

enum ElementType {
	# The elements
	AIR, WATER, FIRE, EARTH,
	# The primes
	BODY, SOUL, MERCURY
}

func _ready():
	texture = tile_images[tile_type]

	if tile_type == ElementType.AIR:
		
		pass
	elif tile_type == ElementType.WATER:
		pass
	elif tile_type == ElementType.FIRE:
		pass
	elif tile_type == ElementType.EARTH:
		pass
	elif tile_type == ElementType.BODY:
		pass
	elif tile_type == ElementType.SOUL:
		pass
	elif tile_type == ElementType.MERCURY:

		pass
	else:
		texture = load("res://icon.svg")
	custom_minimum_size.x = side_length
	custom_minimum_size.y = side_length
