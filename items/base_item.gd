extends Node2D
class_name BaseItem

@export var placeable: Placability = Placability.OnTile
@export var is_on_enemy: bool = true
@export var delayed_action: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("active_items")

func check_prerequisite():
	pass

func item_action():
	pass

enum Placability {
	NotPlaceable, OnShadow, OnTile
	#, AttachedOnTile
}