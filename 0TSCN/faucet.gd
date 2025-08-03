extends StaticBody3D

@onready var river: MeshInstance3D = get_tree().get_first_node_in_group("river")
@onready var tree: StaticBody3D = get_tree().get_first_node_in_group("interactableTree")


func activateInteractable():
	if river.visible == false:
		river.visible = true
		$AnimatedSprite3D.play("on")
		tree.dead=false
		
	else:
		river.visible = false
		tree.dead=true
		$AnimatedSprite3D.play("off")
	
