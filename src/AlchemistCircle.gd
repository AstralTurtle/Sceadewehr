extends Control
class_name AlchemistCircle

@export var recipies: Array[Recipe]
var holdings: Array[Tile.ElementType]
var held_recipe: Recipe = null
var held_item: HeldItem = null
var player: int

@onready var slot1: Button = $Slot1
@onready var slot2: Button = $Slot2
@onready var slot1_texture: TextureRect = $Slot1/Slot1Texture
@onready var slot2_texture: TextureRect = $Slot2/Slot2Texture
@onready var cursed_parent: GameBoard = get_tree().get_first_node_in_group("game_board_group")
var essence_images = {
	Tile.ElementType.AIR: load('res://assets/AirEssence.png'),
	Tile.ElementType.WATER: load('res://assets/WaterEssence.png'),
	Tile.ElementType.FIRE: load('res://assets/FireEssence.png'),
	Tile.ElementType.EARTH: load('res://assets/EarthEssence.png'),
	Tile.ElementType.BODY: load('res://assets/BodyEssence.png'),
	Tile.ElementType.SOUL: load('res://assets/SoulEssence.png'),
	Tile.ElementType.MERCURY: load('res://assets/MercuryEssence.png')
}

signal send_back(item: Tile.ElementType)
signal used_item(item: PackedScene)

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

func use_ingridients():
	held_recipe = null
	holdings.clear()
	visualize()

func clear_item(ind: int):
	held_recipe = null
	emit_signal(send_back.get_name(), holdings[ind])
	holdings.remove_at(ind)
	visualize()

func add_item(item: Tile.ElementType):
	if (holdings.size() >= 2 || held_item != null):
		emit_signal(send_back.get_name(), item)
		return
	holdings.append(item)
	if (holdings.size() == 2):
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
	if held_recipe != null && held_item == null:
		var item = HeldItem.new()
		item.item_scene = held_recipe.item_scene
		item.texture_normal = held_recipe.item_thumbnail
		item.scale = Vector2(4, 4)
		item.position = Vector2(31, 16)
		add_child(item)
		var hack = held_item_pressed
		var why_though = func():
			item.pressed.connect(hack)
		item.modulate = Color(0.46, 0.46, 0.451, 0.537)
		cursed_parent.swap_complete.connect(func():
			item.modulate = Color(1.0, 1.0, 1.0, 1.0)
			cursed_parent.swap_complete.connect(why_though, CONNECT_ONE_SHOT)
		, CONNECT_ONE_SHOT
		)
		held_item = item
		use_ingridients()

func held_item_pressed():
	used_item.emit(held_item.item_scene)
	held_item.queue_free()
