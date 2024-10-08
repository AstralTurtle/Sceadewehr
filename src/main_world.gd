extends Control
class_name MainWorld

@onready var player1: PlayerUI = $HBoxContainer/PlayerUi
@onready var player2: PlayerUI = $HBoxContainer/PlayerUi2
@onready var game_board: GameBoard = $HBoxContainer/AspectRatioContainer/ColorRect/GameBoard
@onready var shadow_clones: CloneBoard = $HBoxContainer/AspectRatioContainer/ColorRect/CloneBoard
@onready var music: AudioStreamPlayer = $AudioStreamPlayer
@onready var hurt_sfx: AudioStreamPlayer = $HurtSFX
@onready var turn_change_label: Label = $TurnChangeLabel
@onready var help: Button = $HelpButton
@onready var recipe_book: Control = $RecipeBook
@onready var end_screen: PackedScene = load("res://end_screen.tscn")
var player1_active: bool = true
var is_fs: bool = false

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
	player1.player_name = Globals.player1_name
	player2.set_active(false)
	player2.player_name = Globals.player2_name
	music.play()
	music.finished.connect(music.play)
	music.volume_db = Globals.volume
	turn_change_label.hide()
	recipe_book.hide()
	help.pressed.connect(func(): recipe_book.show())
		
	

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
	if player1.health < 0 && player2.health < 0:
		print("hi")
		Globals.winner = "tie"
		get_tree().change_scene_to_packed(end_screen)
		return
	elif player1.health < 0:
		print("hi")
		Globals.winner = player2.player_name
		get_tree().change_scene_to_packed(end_screen)
		return
	elif player2.health < 0:
		print("hi")
		Globals.winner = player1.player_name
		get_tree().change_scene_to_packed(end_screen)
		return

	turn_change_label.text = "Player 1's Turn!!!" if player1_active else "Player 2's Turn!!!"
	turn_change_label.show()
	var timer: SceneTreeTimer = get_tree().create_timer(0.5)
	timer.timeout.connect(func():
		turn_change_label.hide()
	)
	timer = get_tree().create_timer(0.5)
	await timer.timeout
	turn_change_label.show()
	timer = get_tree().create_timer(0.5)
	await timer.timeout
	turn_change_label.hide()
	
	
func process_damage(damage: int, team: int):
	if team == 1:
		player1.decrease_health(damage)
	elif team == 0:
		player2.decrease_health(damage)
	hurt_sfx.play()

func get_player(num: int):
	if num == 0:
		return player1
	if num == 1:
		return player2

func _input(event):
	if event.is_action_released("Fullscreen"):
		is_fs = !is_fs
		get_tree().root.get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if is_fs else Window.MODE_WINDOWED
