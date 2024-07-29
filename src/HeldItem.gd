extends TextureButton
class_name HeldItem

var item_scene: PackedScene

signal item_triggered(item_scene: PackedScene, pos: Vector2)

func trigger_item(pos: Vector2):
    item_triggered.emit(item_scene, pos)
