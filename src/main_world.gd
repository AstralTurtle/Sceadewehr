extends Control
class_name MainWorld

@onready var player1: PlayerUI = $HBoxContainer/PlayerUi
@onready var player2: PlayerUI = $HBoxContainer/PlayerUi2
@onready var game_board: GameBoard = $HBoxContainer/AspectRatioContainer/ColorRect/GameBoard
@onready var shadow_clones: CloneBoard = $HBoxContainer/AspectRatioContainer/ColorRect/CloneBoard
@onready var music: AudioStreamPlayer = $AudioStreamPlayer
var player1_active: bool = true

var turn_counter = 0

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
	music.play()
	music.finished.connect(music.play)
	music.volume_db = Globals.volume
	


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
	player1.set_active_button(false)
	player2.set_active_button(false)
	game_board.locked = false
	turn_counter += 1
	if turn_counter % 2 == 0:
		get_tree().call_group(ShadowClone.group_name, 'move_forward')
		shadow_clones.create_clone(0)
		shadow_clones.create_clone(1)
    
    
func process_damage(damage: int, team: int):
	print('process damage', damage, team)
	if team == 1:
		player1.decrease_health(damage)
	elif team == 0:
		player2.decrease_health(damage)

func get_player(num: int):
	if num == 0:
		return player1
	if num == 1:
		return player2
