extends StaticBody3D

@onready var river: MeshInstance3D = get_tree().get_first_node_in_group("river")

func activateInteractable():
	if river.visible == false:
		river.visible = true
		$AnimatedSprite3D.play("on")
	else:
		river.visible = false
		$AnimatedSprite3D.play("off")
	
