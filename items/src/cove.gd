extends BaseItem

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func item_action():
	var world: MainWorld = get_tree().root.get_node('MainWorld')
	world.get_player(player).shielded = true
