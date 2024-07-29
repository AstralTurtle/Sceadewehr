extends Control
class_name MainWorld

@onready var player1: PlayerUI = $HBoxContainer/PlayerUi
@onready var player2: PlayerUI = $HBoxContainer/PlayerUi2
@onready var game_board: GameBoard = $HBoxContainer/AspectRatioContainer/ColorRect/GameBoard
@onready var shadow_clones: CloneBoard = $HBoxContainer/AspectRatioContainer/ColorRect/CloneBoard
var player1_active: bool = true

func _ready():
    game_board.swap_complete.connect(continue_turn)
    shadow_clones.do_damage.connect(process_damage)
    game_board.clear_board(game_board.tiles)
    var ing = game_board.dump_ingridients()
    for i in ing:
        player1.add_essence(i)
        player2.add_essence(i)
    player1.set_active(true)
    player2.set_active(false)


func continue_turn():
    var ingridients = game_board.dump_ingridients()
    var active: PlayerUI = player1
    player1.set_active_button(true)
    player2.set_active_button(false)
    if not player1_active:
        player2.set_active_button(true)
        player1.set_active_button(false)
        active = player2
    for i in ingridients:
        active.add_essence(i)
    await active.turn_complete
    print("hello")
    
    # Switch turn
    player1_active = !player1_active
    player1.set_active(player1_active)
    player2.set_active(!player1_active)
    game_board.locked = false
    
    
func process_damage(damage: int, team: int):
    if team == 0:
        player1.health -= damage
    elif team == 1:
        player2.health -= damage