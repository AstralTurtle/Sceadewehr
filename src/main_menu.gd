extends Control

@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var play: Button = $ColorRect/VBoxContainer/Button
@onready var volume: HSlider = $ColorRect/VBoxContainer/HBoxContainer/HSlider
@onready var player1_name: TextEdit = $ColorRect/VBoxContainer/NameHbox/p1/TextEdit
@onready var player2_name: TextEdit = $ColorRect/VBoxContainer/NameHbox/p2/TextEdit
@onready var main_scene: PackedScene = load("res://main_world.tscn")

func _ready():
	audio.play()
	play.pressed.connect(func(): get_tree().change_scene_to_packed(main_scene))
	volume.value_changed.connect(vol_changed)
	player1_name.text_changed.connect(p1_name_change)
	player2_name.text_changed.connect(p2_name_change)
	
func vol_changed(val: float):
	audio.volume_db = val - 5
	Globals.volume = val

func p1_name_change():
	print("hi")
	Globals.player1_name = player1_name.text

func p2_name_change():
	Globals.player2_name = player2_name.text
	