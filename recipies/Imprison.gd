extends BaseItem


var counter = 0
@export var max_turns: int = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func item_action():
	counter += 1
	if (counter > max_turns):
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
