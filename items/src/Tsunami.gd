extends BaseItem

@export var TsunamiScene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	var tsunami: TsunamiActive = TsunamiScene.instantiate()
	tsunami.team = player
	get_tree().root.get_node('MainWorld/HBoxContainer/AspectRatioContainer/ColorRect/CloneBoard').add_child(tsunami)
	tsunami.position = Vector2(1, 314)
	tsunami.start()
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
