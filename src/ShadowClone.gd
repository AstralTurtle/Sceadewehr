extends Sprite2D
class_name ShadowClone

@export var damage: int = 5
var team: int
var stunned: bool = false;
var damp: bool = false;

var textures: Array[Texture] = [load("res://assets/SC1.png"), load("res://assets/SC2.png")]

static var group_name: String = "shadow_clones"
var grid_interval: float
signal do_damage(damage_amount: int, team_num: int)

func move_forward():
	if (stunned):
		stunned = false
		return
	position.y += grid_interval
	if grid_interval*8:
		do_damage.emit(damage / (2 if damp else 1), team)
		queue_free()

func _ready():
	add_to_group(group_name)
	set_team(0)

func set_team(new_team: int):
	team = new_team
	texture = textures[team]