extends Control
class_name MainWorld

@onready var player1: PlayerUI = $HBoxContainer/PlayerUi
@onready var player2: PlayerUI = $HBoxContainer/PlayerUi2
@onready var game_board: GameBoard = $HBoxContainer/AspectRatioContainer/ColorRect/GameBoard
@onready var shadow_clones: CloneBoard = $HBoxContainer/AspectRatioContainer/ColorRect/CloneBoard
@onready var hover_mat: ShaderMaterial = load("res://assets/hover.material")
var player1_active: bool = true

func _ready():
    game_board.swap_complete.connect(continue_turn)
    shadow_clones.do_damage.connect(process_damage)
    var ing = game_board.dump_ingridients()
    player1.essence_list.append_array(ing)
    player1.set_active(true)
    player2.essence_list.append_array(ing)
    player2.set_active(false)

func continue_turn():
    var ingridients = game_board.dump_ingridients()
    var active: PlayerUI = player1
    if not player1_active:
        active = player2
    for i in ingridients:
        active.add_essence(i)
    await active.turn_complete
    print("hello")
    # hover_mat.set_shader_parameter("show", true)
    # hover_mat.set_shader_parameter("show", false)
    
    # Switch turn
    player1_active = !player1_active
    player1.set_active(player1_active)
    player2.set_active(!player1_active)
    game_board.locked = false
    
func _process(_delta):
    hover_mat.set_shader_parameter("mouse_pos", game_board.get_local_mouse_position())
    
func process_damage(damage: int, team: int):
    if team == 0:
        player1.health -= damage
    elif team == 1:
        player2.health -= damage