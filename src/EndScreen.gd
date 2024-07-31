extends Control

@onready var winner: Label = $ColorRect/MarginContainer/VBoxContainer/WinnerLabel
@onready var play_again: Button = $ColorRect/MarginContainer/VBoxContainer/again
@onready var main_scene: PackedScene = load("res://main_world.tscn")
@onready var fs_button: TextureButton = $fullscreen
var is_fs: bool = false

func _ready():
    if Globals.winner == "tie":
        winner.text = "IT'S A TIE!!!"
    else:
        winner.text = Globals.winner + " WINS!!!"
    play_again.pressed.connect(func(): 
        Globals.winner = "tie"
        get_tree().change_scene_to_packed(main_scene)
    )
    fs_button.pressed.connect(func():
        print("heyyy")
        is_fs = !is_fs
        get_tree().root.get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if is_fs else Window.MODE_WINDOWED
    )

func _input(event):
    if event.is_action_released("Fullscreen"):
        is_fs = !is_fs
        get_tree().root.get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if is_fs else Window.MODE_WINDOWED
