extends Node3D

var dead = false

func kill():
	dead = true
	$AudioStreamPlayer3D.play()
	$CollisionShape3D.disabled =  true
	print("can now walk passed")
