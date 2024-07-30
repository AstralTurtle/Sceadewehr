extends Node2D
class_name CloneBoard

static var player_one_goup: String = "shadow_clones1"
static var player_two_goup: String = "shadow_clones2"
@export var perside_creation: int = 2
@onready var shadow_clone: PackedScene = load("res://shadow_clone.tscn")
@onready var game_board: GameBoard = get_node("../GameBoard")

signal do_damage(damage: int, team: int)

func _ready():
	# Player 1
	for i in range(perside_creation):
		create_clone(0)
	# Player 2
	for i in range(perside_creation):
		create_clone(1)

func create_clone(team: int):
	var clone: ShadowClone = shadow_clone.instantiate()
	clone.global_position = get_random_pos()
	clone.grid_interval = game_board.size.x / 8
	clone.add_to_group(player_one_goup if team == 0 else player_two_goup)
	clone.set_team(team)
	clone.do_damage.connect(func(x, y): do_damage.emit(x, y))
	add_child(clone)


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	pass

func get_random_pos() -> Vector2:
	var incr_by: float = game_board.size.x / game_board.columns
	return Vector2(incr_by * randi_range(0, 7) + incr_by / 2, incr_by * randi_range(0, 3) + incr_by / 2)
