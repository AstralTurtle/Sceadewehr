extends BaseItem


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func item_action():
	var world: MainWorld = get_tree().root.get_node('MainWorld')
	world.process_damage(1, 0)
	world.process_damage(1, 1)
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
