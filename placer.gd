extends Node2D
class_name ItemPlacer


var placed: bool = false

signal item_placed(pos: Vector2)

func _input(event):
	if event is InputEventMouseMotion:
		global_position = event.position
	elif event is InputEventMouseButton && !placed:
		item_placed.emit(global_position)
		queue_free()
