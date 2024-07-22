extends Control
class_name AlchemistCircle

@export var recipies: Array[Recipe]
var holdings: Array[Tile.ElementType]
var held_recipe: Recipe = null

var slot1: Button
var slot2: Button

signal send_back(item: Tile.ElementType)

func _ready():
	slot1 = get_node("Slot1")
	slot2 = get_node("Slot2")

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

func add_item(item: Tile.ElementType):
	if(holdings.size() >= 2):
		emit_signal(send_back.get_name(), item)
	holdings.append(item)
	if(holdings.size() == 2):
		validate_recipe()
