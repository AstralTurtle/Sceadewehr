extends Sprite2D
class_name ShadowClone

var grid_interval: float

func move_forward():
	position.y += grid_interval

func _ready():
	add_to_group("shadow_clones")