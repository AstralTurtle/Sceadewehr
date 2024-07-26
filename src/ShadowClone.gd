extends Sprite2D
class_name ShadowClone

var team: int
var stunned: bool = false;

var textures: Array[Texture] = [load("res://assets/SC1.png"), load("res://assets/SC2.png")]

static var group_name: String = "shadow_clones"
var grid_interval: float
var is_first_players: bool

func move_forward():
	if (stunned):
		stunned = false
		return
	position.y += grid_interval

func _ready():
	add_to_group(group_name)
	set_team(0)

func set_team(new_team: int):
	team = new_team
	texture = textures[team]