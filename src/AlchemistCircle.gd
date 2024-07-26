extends Control
class_name AlchemistCircle

@export var recipies: Array[Recipe]
var holdings: Array[Tile.ElementType]
var held_recipe: Recipe = null

@onready var slot1: Button = $Slot1
@onready var slot2: Button = $Slot2
@onready var slot1_texture: TextureRect = $Slot1/Slot1Texture
@onready var slot2_texture: TextureRect = $Slot2/Slot2Texture
var essence_images = {
	Tile.ElementType.AIR: load('res://assets/AirEssence.png'),
	Tile.ElementType.WATER: load('res://assets/WaterEssence.png'),
	Tile.ElementType.FIRE: load('res://assets/FireEssence.png'),
	Tile.ElementType.EARTH: load('res://assets/EarthEssence.png'),
	Tile.ElementType.BODY:  load('res://assets/Body.png'),
	Tile.ElementType.SOUL: load('res://assets/Soul.png'),
	Tile.ElementType.MERCURY: load('res://assets/Mercury.png')
}

signal send_back(item: Tile.ElementType)
signal crafted_item(item)

func _ready():
	pass

func validate_recipe():
	for r in recipies:
		if r.is_valid(holdings):
			held_recipe = r
	if held_recipe == null:
		clear_items()

func clear_items():
	held_recipe = null
	for item in holdings:
		emit_signal(send_back.get_name(), item)
	holdings.clear()
	visualize()

func clear_item(ind: int):
	held_recipe = null
	emit_signal(send_back.get_name(), holdings[ind])
	holdings.remove_at(ind)
	visualize()

func add_item(item: Tile.ElementType):
	if(holdings.size() >= 2):
		emit_signal(send_back.get_name(), item)
		return
	holdings.append(item)
	if(holdings.size() == 2):
		validate_recipe()
	visualize()

func visualize():
	if holdings.size() > 0:
		slot1_texture.texture = essence_images.get(holdings[0])
	else:
		slot1_texture.texture = null
	if holdings.size() > 1:
		slot2_texture.texture = essence_images.get(holdings[1])
	else:
		slot2_texture.texture = null

func craft():
	crafted_item.emit(held_recipe.item_scene)
