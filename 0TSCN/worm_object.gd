extends StaticBody3D

@onready var switch_manager: Node3D = get_tree().get_first_node_in_group("switch_manager")  # Switch Manager to get the state
@onready var player: CharacterBody3D 

func activateMinigame():
	
	var character_num = switch_manager.getState()
	print("deleting minigame for player %s" % character_num)
	player = get_tree().get_nodes_in_group("player")[character_num]
	if 'stick' in player.inventory:
	#Worm dies after poking
	#$CollisionShape3D.disabled=true
	#$WormMesh.visible=false
		return "EyePoker"
	else:
		print("no stick")
