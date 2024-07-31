extends BaseItem

@export var tailwindScene: PackedScene


# Called when the node enters the scene tree for the first time.
 # Replace with function body.
func _ready():
	print('css?')
	var tailwind: TailwindActive = tailwindScene.instantiate()
	tailwind.team = player
	get_tree().root.get_node('MainWorld/HBoxContainer/AspectRatioContainer/ColorRect/CloneBoard').add_child(tailwind)
	tailwind.position = Vector2(-15, 30)
	tailwind.start()
	queue_free()

func item_action():
	print('bs?')
	var tailwind: TailwindActive = tailwindScene.instantiate()
	tailwind.team = player
	get_tree().root.get_node('MainWorld/HBoxContainer/AspectRatioContainer/ColorRect/CloneBoard').add_child(tailwind)
	tailwind.position = Vector2(-15, 30)
	tailwind.start()
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
