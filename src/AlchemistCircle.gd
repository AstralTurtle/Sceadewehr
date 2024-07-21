extends Control

@export var recipies: Array[Recipe]
var holdings: Array[Tile.ElementType]
var held_recipe: Recipe = null

var slot1: Button
var slot2: Button

func _ready():
    slot1 = get_node("Slot1")
    slot2 = get_node("Slot2")
    print('hello')

func validate_recipe():
    for r in recipies:
        if r.is_valid(holdings):
            held_recipe = r

func clear_item(ind):
    print(ind)
    holdings.remove_at(ind)
	# add item back to inventory
    held_recipe = null

func add_item(ind, item):
    holdings[ind] = item
    # remove from inventory
    validate_recipe()