extends Control

@export var recipies: Array[Recipe]
@onready var item_line: PackedScene = load("res://item_line.tscn")
@onready var essence_line: PackedScene = load("res://essence_line.tscn")
@onready var thing: VBoxContainer = $TabContainer/Recipies/MarginContainer/ScrollContainer/VBoxContainer
@onready var essence: VBoxContainer = $TabContainer/Essences/MarginContainer/ScrollContainer/VBoxContainer
@onready var close: Button = $Close

var tile_images = {
	Tile.ElementType.AIR: load('res://assets/Air.png'),
	Tile.ElementType.WATER: load('res://assets/Water.png'),
	Tile.ElementType.FIRE: load('res://assets/Fire.png'),
	Tile.ElementType.EARTH: load('res://assets/Earth.png'),
	Tile.ElementType.BODY: load('res://assets/Body.png'),
	Tile.ElementType.SOUL: load('res://assets/Soul.png'),
	Tile.ElementType.MERCURY: load('res://assets/Mercury.png'),
}

var essence_images = {
	Tile.ElementType.AIR: load('res://assets/AirEssence.png'),
	Tile.ElementType.WATER: load('res://assets/WaterEssence.png'),
	Tile.ElementType.FIRE: load('res://assets/FireEssence.png'),
	Tile.ElementType.EARTH: load('res://assets/EarthEssence.png'),
	Tile.ElementType.BODY: load('res://assets/BodyEssence.png'),
	Tile.ElementType.SOUL: load('res://assets/SoulEssence.png'),
	Tile.ElementType.MERCURY: load('res://assets/MercuryEssence.png')
}

func _ready():
	for recipe in recipies:
		var it: ItemLine = item_line.instantiate()
		thing.add_child(it)
		it.set_item_line(recipe.ingridients[0], recipe.ingridients[1], recipe.recipe_text)
	for i in range(0, 7):
		var it: ItemLine = essence_line.instantiate()
		essence.add_child(it)
		it.set_essence_line(tile_images[i], essence_images[i], Tile.ElementType.keys()[i])
	close.pressed.connect(hide)
		
func _input(event):
	if event.is_action_released("ui_cancel"):
		hide()
