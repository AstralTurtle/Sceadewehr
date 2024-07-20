extends Control

@export var player_name: String = ""
@onready var name_label: Label = get_node("MarginContainer/HBoxContainer/VBoxContainer/NameLabel")
@onready var inventory: FlowContainer = get_node("MarginContainer/HBoxContainer/VBoxContainer/Inventory")
@onready var alchemist_crafter: Control = get_node("MarginContainer/HBoxContainer/VBoxContainer/AlchemistCircle")
@onready var result_box: Control = get_node("MarginContainer/HBoxContainer/VBoxContainer/ResultBox")
var active: bool = true

func _ready():
	name_label.text = player_name

func toggle_active():
	active = !active
	if(active):
		name_label.label_settings.font_color = Color(1.1, 1.1, 1.1, 1.1)
	else:
		name_label.label_settings.font_color = Color(1, 1, 1, 0.8)