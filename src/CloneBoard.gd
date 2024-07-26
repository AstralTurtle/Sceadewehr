extends Node2D
class_name CloneBoard

static var player_one_goup: String = "shadow_clones1"
static var player_two_goup: String = "shadow_clones2"
@export var perside_creation: int = 5
@onready var shadow_clone: PackedScene = load("res://shadow_clone.tscn")
@onready var game_board: GameBoard = get_node("../GameBoard")

func _ready():
	# Player 1
	for i in range(perside_creation):
		var clone: ShadowClone = shadow_clone.instantiate()
		clone.global_position = get_random_pos()
		clone.grid_interval = game_board.size.x/game_board.columns
		clone.add_to_group(player_one_goup)
		clone.is_first_players = true
		add_child(clone)
	# Player 2
	for i in range(perside_creation):
		var clone: ShadowClone = shadow_clone.instantiate()
		clone.global_position = get_random_pos()
		clone.grid_interval = game_board.size.x/game_board.columns
		clone.add_to_group(player_two_goup)
		clone.is_first_players = false
		add_child(clone)


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	pass

func get_random_pos() -> Vector2:
	var incr_by: float = game_board.size.x/game_board.columns
	return Vector2(incr_by*randi_range(0,7)+incr_by/2, incr_by*randi_range(0,7)+incr_by/2)
