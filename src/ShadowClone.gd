extends Sprite2D
class_name ShadowClone


@export var damage: int = 5
@export var move_anim_time: float = 0.25
var team: int
var stunned: bool = false;
var damp: bool = false;


var textures: Array[Texture] = [load("res://assets/SC1.png"), load("res://assets/SC2.png")]


@onready var body: AnimatableBody2D = get_node('Body')

static var group_name: String = "shadow_clones"
var grid_interval: float
signal do_damage(damage_amount: int, team_num: int)

func move_forward():
	if (stunned):
		stunned = false
		return
	var new_movement = Vector2(position.x, position.y + grid_interval)
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", new_movement, move_anim_time)

	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_OUT)
	
	if position.y > grid_interval * 8:
		do_damage.emit(damage / (2 if damp else 1), team)
		queue_free()

func destroy():
	if !damp:
		do_damage.emit(damage / 2, (team + 1) % 2)
	queue_free()

func _ready():
	add_to_group(group_name)

func set_team(new_team: int):
	team = new_team
	texture = textures[team]