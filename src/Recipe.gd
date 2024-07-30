extends Resource
class_name Recipe

@export var ingridients: Array[Tile.ElementType]
@export var item_scene: PackedScene
@export var item_thumbnail: Texture2D
# @export var result: Result type not defined yet

func is_valid(proposed: Array[Tile.ElementType]) -> bool:
    if ingridients.size() != proposed.size():
        return false
    for i in proposed:
        if ingridients.count(i) != proposed.count(i):
            return false
    return true