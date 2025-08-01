class_name MainMenu
extends Control

@onready var start_level = preload("res://3DMaps/3d_doom_map.tscn")
@onready var start_button: Button = $CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/StartButton
@onready var exit_button: Button = $CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/ExitButton

func _ready():
	start_button.button_up.connect(start)
	exit_button.button_up.connect(exit)

func exit():
	get_tree().quit()

func start():
	get_tree().change_scene_to_packed(start_level)
