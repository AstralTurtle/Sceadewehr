extends TextureButton
class_name HeldItem

var placer: PackedScene
var item_scene: PackedScene

signal item_triggered(item_scene: PackedScene, pos: Vector2)

func spawn_placer():
    var p: ItemPlacer = placer.instantiate()
    p.item_placed.connect(trigger_item)

func trigger_item(pos: Vector2):
    item_triggered.emit(item_scene, pos)
