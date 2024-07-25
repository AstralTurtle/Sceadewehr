extends Control

@onready var player1: PlayerUI = $HBoxContainer/PlayerUi
@onready var player2: PlayerUI = $HBoxContainer/PlayerUi2
@onready var game_board: GameBoard = $HBoxContainer/AspectRatioContainer/ColorRect/GameBoard
@onready var shadow_clones: CloneBoard = $HBoxContainer/AspectRatioContainer/ColorRect/CloneBoard
var player1_active: bool = true

func _ready():
    game_board.turn_complete.connect(turn_complete)

func turn_complete():
    if player1_active:
        pass
    else:
        pass
    player1_active = !player1_active