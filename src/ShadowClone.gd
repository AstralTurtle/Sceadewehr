extends CharacterBody2D
class_name ShadowClone


@export var damage: int = 5

var speed = 400

var team: int
var stunned: bool = false;
var damp: bool = false;
@onready var target: Vector2 = position

@export var textures: Array[Texture] = []


static var group_name: String = "shadow_clones"
var grid_interval: float
signal do_damage(damage_amount: int, team_num: int)

func move_forward():
	if (stunned):
		stunned = false
		return
	target = Vector2(position.x, position.y + grid_interval)
	if position.y > grid_interval * 8:
		do_damage.emit(damage / (2 if damp else 1), team)
		queue_free()

func move_backwards(steps: int):
	target = Vector2(position.x, position.y - grid_interval * steps)

func apply_stun():
	target = position
	stunned = true

func destroy():
	if !damp:
		do_damage.emit(damage / 2, (team + 1) % 2)
	queue_free()

func _ready():
	add_to_group(group_name)

func set_team(new_team: int):
	team = new_team
	get_node('Sprite2D').texture = textures[team]

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 10:
		move_and_slide()
