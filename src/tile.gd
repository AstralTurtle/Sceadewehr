extends TextureRect
class_name Tile

@export var tile_type: ElementType

func _ready():
	pass # Replace with function body.


enum ElementType {
	# The elements
	AIR, WATER, FIRE, EARTH,
	# The primes
	BODY, SOUL, MERCURY
}