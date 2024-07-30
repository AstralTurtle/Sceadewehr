extends BaseItem

@onready var buttons: Array[TextureButton] = [
 $Control/Panel/TextureButton0,
 $Control/Panel/TextureButton1,
 $Control/Panel/TextureButton2,
 $Control/Panel/TextureButton3,
 $Control/Panel/TextureButton4,
 $Control/Panel/TextureButton5,
 $Control/Panel/TextureButton6,
]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func item_action():
	for i in range(buttons.size()):
		buttons[i].pressed.connect(add_item.bind(i))
	

func add_item(ind: int):
	var world: MainWorld = get_tree().root.get_node('MainWorld')
	if (player == 0):
		world.player1.add_essence(ind)
	else:
		world.player2.add_essence(ind)
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
