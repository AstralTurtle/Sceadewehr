extends TextureRect
class_name Tile

@export var tile_type: ElementType
var side_length: float = 50

enum ElementType {
	# The elements
	AIR, WATER, FIRE, EARTH,
	# The primes
	BODY, SOUL, MERCURY
}

func _ready():
	if tile_type == ElementType.AIR:
		# texture =
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
	texture = load("res://icon.svg")
	custom_minimum_size.x = side_length
	custom_minimum_size.y = side_length
	