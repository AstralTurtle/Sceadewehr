extends Node2D

@onready var shadow_clone: PackedScene = load("res://shadow_clone.tscn")
@onready var game_board: GameBoard = get_node("../GameBoard")

func _ready():
	for i in range(10):
		var clone: ShadowClone = shadow_clone.instantiate()
		clone.global_position = get_random_pos()
		clone.grid_interval = game_board.size.x/game_board.columns
		add_child(clone)
		game_board.turn_complete.connect(clone.move_forward)


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	pass

func get_random_pos() -> Vector2:
	var incr_by: float = game_board.size.x/game_board.columns
	return Vector2(incr_by*randi_range(0,7)+incr_by/2, incr_by*randi_range(0,7)+incr_by/2)
