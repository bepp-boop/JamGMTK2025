extends Control


@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")
@onready var exitbutton: Button = $MarginContainer/ColorRect/HBoxContainer/Exitbutton
@onready var texture_rect: TextureRect = $MarginContainer/ColorRect/HBoxContainer/TextureRect


func _ready():
	exitbutton.button_up.connect(finish_game)

func _process(delta: float) -> void:
	texture_rect.rotation += 0.1
		
func finish_game():
	player.end_minigame()
	
