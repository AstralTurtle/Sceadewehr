extends Control

@export var recipies: Array[Recipe]
@onready var item_line: PackedScene = load("res://item_line.tscn")
@onready var thing: VBoxContainer = $ColorRect/MarginContainer/ScrollContainer/VBoxContainer

func _ready():
	for recipe in recipies:
		var it: ItemLine = item_line.instantiate()
		thing.add_child(it)
		it.set_line(recipe.ingridients[0], recipe.ingridients[1], recipe.recipe_text)
