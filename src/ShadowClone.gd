extends Sprite2D
class_name ShadowClone

static var group_name: String = "shadow_clones"
var grid_interval: float

func move_forward():
	position.y += grid_interval

func _ready():
	add_to_group(group_name)