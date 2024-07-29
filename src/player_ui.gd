extends Control
class_name PlayerUI

@export var player_name: String = ""
@export var health = 10
@onready var name_label: Label = get_node("MarginContainer/HBoxContainer/VBoxContainer/NameLabel")
@onready var inventory: FlowContainer = get_node("MarginContainer/HBoxContainer/VBoxContainer/Inventory")
@onready var alchemist_crafter: AlchemistCircle = get_node("MarginContainer/HBoxContainer/VBoxContainer/Control/AlchemistCircle")
@onready var end_turn: Button = get_node("MarginContainer/HBoxContainer/VBoxContainer/EndTurnButton")
@onready var game_board: GameBoard = get_tree().get_first_node_in_group("game_board_group")
@onready var hover_mat: ShaderMaterial = load("res://assets/hover.material")
var essence_images = {
	Tile.ElementType.AIR: load('res://assets/AirEssence.png'),
	Tile.ElementType.WATER: load('res://assets/WaterEssence.png'),
	Tile.ElementType.FIRE: load('res://assets/FireEssence.png'),
	Tile.ElementType.EARTH: load('res://assets/EarthEssence.png'),
	Tile.ElementType.BODY: load('res://assets/BodyEssence.png'),
	Tile.ElementType.SOUL: load('res://assets/SoulEssence.png'),
	Tile.ElementType.MERCURY: load('res://assets/MercuryEssence.png')
}
var essence_list: Array[Tile.ElementType]


signal turn_complete()
signal mouse_pressed()

func _ready():
	name_label.text = player_name
	var old_settings = name_label.label_settings
	name_label.label_settings = old_settings.duplicate()
	alchemist_crafter.send_back.connect(add_essence)
	alchemist_crafter.used_item.connect(place_item)
	end_turn.pressed.connect(alchemist_crafter.craft)
	end_turn.pressed.connect(func(): turn_complete.emit())
	end_turn.disabled = true
	add_essence(Tile.ElementType.FIRE)
	add_essence(Tile.ElementType.FIRE)

func set_active(is_active: bool):
	if (is_active):
		name_label.label_settings.font_color = Color(1.1, 1.1, 1.1, 1.1)
	else:
		name_label.label_settings.font_color = Color(1, 1, 1, 0.5)
		
func set_active_button(is_active: bool):
	if (is_active):
		end_turn.disabled = false
	else:
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
	
func place_item(item_scene: PackedScene):
	var item: BaseItem = item_scene.instantiate()
	# Add item somewhere on scene tree, based of placebility
	if item.placeable == BaseItem.Placability.NotPlaceable:
		get_tree().root.add_child(item)
	elif item.placeable == BaseItem.Placability.OnTile:
		var place_pos = await place_on_grid()
		get_tree().root.get_node('MainWorld/HBoxContainer/AspectRatioContainer/ColorRect/CloneBoard').add_child(item)
		item.position = place_pos
	elif item.placeable == BaseItem.Placability.OnShadow:
		get_tree().root.get_node('MainWorld/HBoxContainer/AspectRatioContainer/ColorRect/CloneBoard')

	if item.delayed_action:
		turn_complete.connect(item.item_action)
	else:
		item.item_action()

func _input(event):
	if event.is_action_released("mouse_press"):
		mouse_pressed.emit()

func place_on_grid() -> Vector2:
	hover_mat.set_shader_parameter("show", true)
	await mouse_pressed
	hover_mat.set_shader_parameter("show", false)
	var remouse_pos = floor((game_board.get_local_mouse_position() / game_board.size.x) * 8.0) * game_board.size.x / 8.0;
	remouse_pos.x += game_board.size.x / 8 / 3
	remouse_pos.y += game_board.size.x / 8 / 3
	return remouse_pos

func skip():
	turn_complete.emit()

func _process(_delta):
	hover_mat.set_shader_parameter("mouse_pos", game_board.get_local_mouse_position())