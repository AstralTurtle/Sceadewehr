extends BaseItem


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func item_action():
	var groupname = "shadow_clones" + str(player + 1)
	get_tree().call_group(groupname, 'move_forward')
	queue_free()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
