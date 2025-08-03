extends StaticBody3D

@onready var switch_manager: Node3D = get_tree().get_first_node_in_group("switch_manager")  # Switch Manager to get the state

func activateMinigame():
	#Worm dies after poking
	#$CollisionShape3D.disabled=true
	#$WormMesh.visible=false
	return "EyePoker"
