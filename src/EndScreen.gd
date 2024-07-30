extends Control

@onready var winner: Label = $ColorRect/MarginContainer/VBoxContainer/WinnerLabel
@onready var play_again: Button = $ColorRect/MarginContainer/VBoxContainer/again
@onready var main_scene: PackedScene = load("res://main_world.tscn")

func _ready():
    if Globals.winner == "tie":
        winner.text = "IT'S A TIE!!!"
    else:
        winner.text = Globals.winner + " WINS!!!"
    play_again.pressed.connect(func(): 
        Globals.winner = "tie"
        get_tree().change_scene_to_packed(main_scene)
    )
