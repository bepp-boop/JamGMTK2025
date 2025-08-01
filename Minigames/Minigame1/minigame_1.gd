extends Node2D

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("debugbutton"):
		finish_game()
		
func finish_game():
	player.end_minigame()
	
