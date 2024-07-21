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
	if tile_type == ElementType.AIR:
		# texture =
		texture = tile_images[ElementType.AIR]
		pass
	elif tile_type == ElementType.WATER:
		texture = tile_images[ElementType.WATER]
		pass
	elif tile_type == ElementType.FIRE:
		texture = tile_images[ElementType.FIRE]
		pass
	elif tile_type == ElementType.EARTH:
		texture = tile_images[ElementType.EARTH]
		pass
	elif tile_type == ElementType.BODY:
		texture = tile_images[ElementType.BODY]
		pass
	elif tile_type == ElementType.SOUL:
		texture = tile_images[ElementType.SOUL]
		pass
	elif tile_type == ElementType.MERCURY:
		texture = tile_images[ElementType.MERCURY]
		pass
	else:
		texture = load("res://icon.svg")
	custom_minimum_size.x = side_length
	custom_minimum_size.y = side_length
