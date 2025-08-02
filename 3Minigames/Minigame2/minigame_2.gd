extends Control


@onready var player: CharacterBody3D 
@onready var switch_manager: Node3D =  get_tree().get_first_node_in_group("switch_manager")
@onready var exitbutton: Button = $MarginContainer/ColorRect/HBoxContainer/Exitbutton
@onready var texture_rect: TextureRect = $MarginContainer/ColorRect/HBoxContainer/TextureRect


func _ready():
	exitbutton.button_up.connect(finish_game)

func _process(delta: float) -> void:
	texture_rect.rotation += 0.1
		
func finish_game():
	var character_num = switch_manager.getState()
	print("deleting minigame for player %s" % character_num)
	player = get_tree().get_nodes_in_group("player")[character_num]
	player.end_minigame()
	
