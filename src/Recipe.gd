extends Resource
class_name Recipe

@export var ingridients: Array[Tile.ElementType]
# @export var result: Result type not defined yet

func is_valid(proposed: Array[Tile.ElementType]) -> bool:
    if ingridients.size() != proposed.size():
        return false
    for i in proposed:
        if !ingridients.has(i):
            return false
    return true