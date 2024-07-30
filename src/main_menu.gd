extends Control

@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var play: Button = $ColorRect/VBoxContainer/Button
@onready var volume: HSlider = $ColorRect/VBoxContainer/HBoxContainer/HSlider
@onready var main_scene: PackedScene = load("res://main_world.tscn")

func _ready():
    audio.play()
    play.pressed.connect(func(): get_tree().change_scene_to_packed(main_scene))
    volume.value_changed.connect(vol_changed)
    
func vol_changed(val: float):
    audio.volume_db = val + 10
    Globals.volume = val
