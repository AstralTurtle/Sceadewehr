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
    active.essence_list.append_array(ingridients)
    hover_mat.set_shader_parameter("show", true)
    # await active.turn_complete
    hover_mat.set_shader_parameter("show", false)
    for item in get_tree().get_nodes_in_group(BaseItem.group_name):
        item.check_prerequisite()
    
    # Switch turn
    player1_active = !player1_active
    player1.set_active(player1_active)
    player2.set_active(!player1_active)
    
func _process(_delta):
    hover_mat.set_shader_parameter("mouse_pos", game_board.get_local_mouse_position())
    
func process_damage(damage: int, team: int):
    if team == 0:
        player1.health -= damage
    elif team == 1:
        player2.health -= damage