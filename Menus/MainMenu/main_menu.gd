class_name MainMenu
extends Control

@onready var StartButton = $CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/StartButton as Button
@onready var start_level = preload("res://3DMaps/3d_doom_map.tscn")

func _ready():
	StartButton.button_up.connect(start)
	

func start():
	get_tree().change_scene_to_packed(start_level)
