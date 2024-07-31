extends HBoxContainer
class_name ItemLine

@onready var item1Tex: TextureRect = $Item1
@onready var item2Tex: TextureRect = $Item2
@onready var output: Label = $Output

var essence_images = {
	Tile.ElementType.AIR: load('res://assets/AirEssence.png'),
	Tile.ElementType.WATER: load('res://assets/WaterEssence.png'),
	Tile.ElementType.FIRE: load('res://assets/FireEssence.png'),
	Tile.ElementType.EARTH: load('res://assets/EarthEssence.png'),
	Tile.ElementType.BODY: load('res://assets/BodyEssence.png'),
	Tile.ElementType.SOUL: load('res://assets/SoulEssence.png'),
	Tile.ElementType.MERCURY: load('res://assets/MercuryEssence.png')
}

func set_line(i1: Tile.ElementType, i2: Tile.ElementType, output_str: String):
	item1Tex.texture = essence_images[i1]
	item2Tex.texture = essence_images[i2]
	output.text = output_str
