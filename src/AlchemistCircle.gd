extends Control

@export var recipies: Array[Recipe]
var holdings: Array[Tile.ElementType]
var held_recipe: Recipe = null

func validate_recipe():
    for r in recipies:
        if r.is_valid(holdings):
            held_recipe = r