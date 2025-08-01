extends Node2D

@onready var player: CharacterBody3D 
@onready var switch_manager: Node3D =  get_tree().get_first_node_in_group("switch_manager")


func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("debugbutton"):
		finish_game()
	
		
func finish_game():
	var character_num = switch_manager.getState()
	print("deleting minigame for player %s" % character_num)
	player = get_tree().get_nodes_in_group("player")[character_num]
	player.end_minigame()
	
