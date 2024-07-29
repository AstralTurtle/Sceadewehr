extends Control
class_name PlayerUI

@export var player_name: String = ""
@export var health = 10
@onready var name_label: Label = get_node("MarginContainer/HBoxContainer/VBoxContainer/NameLabel")
@onready var inventory: FlowContainer = get_node("MarginContainer/HBoxContainer/VBoxContainer/Inventory")
@onready var alchemist_crafter: AlchemistCircle = get_node("MarginContainer/HBoxContainer/VBoxContainer/Control/AlchemistCircle")
@onready var end_turn: Button = get_node("MarginContainer/HBoxContainer/VBoxContainer/EndTurnButton")
var essence_images = {
	Tile.ElementType.AIR: load('res://assets/AirEssence.png'),
	Tile.ElementType.WATER: load('res://assets/WaterEssence.png'),
	Tile.ElementType.FIRE: load('res://assets/FireEssence.png'),
	Tile.ElementType.EARTH: load('res://assets/EarthEssence.png'),
	Tile.ElementType.BODY: load('res://assets/Body.png'),
	Tile.ElementType.SOUL: load('res://assets/Soul.png'),
	Tile.ElementType.MERCURY: load('res://assets/Mercury.png')
}
var essence_list: Array[Tile.ElementType]


signal turn_complete()

func _ready():
	name_label.text = player_name
	var old_settings = name_label.label_settings
	name_label.label_settings = old_settings.duplicate()
	alchemist_crafter.send_back.connect(add_essence)
	alchemist_crafter.used_item.connect(place_item)
	end_turn.pressed.connect(alchemist_crafter.craft)
	end_turn.pressed.connect(func(): turn_complete.emit())
	add_essence(Tile.ElementType.FIRE)
	add_essence(Tile.ElementType.FIRE)

func set_active(is_active: bool):
	if (is_active):
		name_label.label_settings.font_color = Color(1.1, 1.1, 1.1, 1.1)
		end_turn.disabled = false
	else:
		name_label.label_settings.font_color = Color(1, 1, 1, 0.5)
		end_turn.disabled = true

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
	
func place_item(item_scene: PackedScene, pos: Vector2):
	var item: BaseItem = item_scene.instantiate()
	item.global_position = pos
	# Add item somewhere on scene tree, based of placebility
	if item.placeable == BaseItem.Placability.NotPlaceable:
		get_tree().root.add_child(item)
	elif item.placeable == BaseItem.Placability.OnTile:
		get_tree().root.get_node('MainWorld/HBoxContainer/AspectRatioContainer/ColorRect/CloneBoard')
		pass
	elif item.placeable == BaseItem.Placability.OnShadow:
		get_tree().root.get_node('MainWorld/HBoxContainer/AspectRatioContainer/ColorRect/CloneBoard')
		pass
	if item.delayed_action:
		turn_complete.connect(item.item_action)
	else:
		item.item_action()

func skip():
	turn_complete.emit()