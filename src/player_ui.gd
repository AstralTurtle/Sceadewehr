extends Control
class_name PlayerUI

@export var player_name: String = ""
@onready var name_label: Label = get_node("MarginContainer/HBoxContainer/VBoxContainer/NameLabel")
@onready var inventory: FlowContainer = get_node("MarginContainer/HBoxContainer/VBoxContainer/Inventory")
@onready var alchemist_crafter: AlchemistCircle = get_node("MarginContainer/HBoxContainer/VBoxContainer/Control/AlchemistCircle")
@onready var result_box: Control = get_node("MarginContainer/HBoxContainer/VBoxContainer/ResultBox")
var essence_images = {
	Tile.ElementType.AIR: load('res://assets/AirEssence.png'),
	Tile.ElementType.WATER: load('res://assets/WaterEssence.png'),
	Tile.ElementType.FIRE: load('res://assets/FireEssence.png'),
	Tile.ElementType.EARTH: load('res://assets/EarthEssence.png'),
	Tile.ElementType.BODY:  load('res://assets/Body.png'),
	Tile.ElementType.SOUL: load('res://assets/Soul.png'),
	Tile.ElementType.MERCURY: load('res://assets/Mercury.png')
}
var essence_list: Array[Tile.ElementType]
var active: bool = true

func _ready():
	name_label.text = player_name
	alchemist_crafter.connect("send_back", add_essence)
	add_essence(Tile.ElementType.AIR)
	add_essence(Tile.ElementType.AIR)
	add_essence(Tile.ElementType.AIR)

func toggle_active():
	active = !active
	if (active):
		name_label.label_settings.font_color = Color(1.1, 1.1, 1.1, 1.1)
	else:
		name_label.label_settings.font_color = Color(1, 1, 1, 0.8)

func send_ingridient(button: TextureButton, essence: Tile.ElementType):
	alchemist_crafter.add_item(essence)
	button.queue_free()

func add_essence(essence: Tile.ElementType):
	essence_list.append(essence)
	var essence_rect = TextureButton.new()
	essence_rect.texture_normal = essence_images.get(essence)
	var send_recipe = func(): send_ingridient(essence_rect, essence)
	essence_rect.connect("button_up", send_recipe)
	inventory.add_child(essence_rect)
	