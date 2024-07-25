extends Sprite2D
class_name ShadowClone

var grid_interval: float

func move_forward():
	position.y += grid_interval

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	pass
