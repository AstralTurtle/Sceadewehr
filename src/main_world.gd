extends Control

@onready var player1: PlayerUI = $HBoxContainer/PlayerUi
@onready var player2: PlayerUI = $HBoxContainer/PlayerUi2
@onready var game_board: GameBoard = $HBoxContainer/AspectRatioContainer/ColorRect/GameBoard
@onready var shadow_clones: CloneBoard = $HBoxContainer/AspectRatioContainer/ColorRect/CloneBoard
@onready var hover_mat: ShaderMaterial = load("res://assets/hover.material")
var player1_active: bool = true

func _ready():
    game_board.swap_complete.connect(continue_turn)
    var ing = game_board.dump_ingridients()
    player1.essence_list.append_array(ing)
    player2.essence_list.append_array(ing)

func continue_turn():
    var ingridients = game_board.dump_ingridients()
    var active: PlayerUI = player1
    if not player1_active:
        active = player2
    active.essence_list.append_array(ingridients)
    hover_mat.set_shader_parameter("show", true)
    # await active.turn_complete
    hover_mat.set_shader_parameter("show", false)
    
    # Switch turn
    player1_active = !player1_active
    player1.set_active(player1_active)
    player2.set_active(!player1_active)
    
func _process(_delta):
    hover_mat.set_shader_parameter("mouse_pos", game_board.get_local_mouse_position())