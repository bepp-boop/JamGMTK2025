extends Node3D

var dead = false

func kill():
	print("kill() method triggered")  # Debugging message to confirm it's called
	dead = true
	$AudioStreamPlayer3D.play()  # Play the audio

	# Delete collision so player can pass through
	$StaticBody3D/CollisionShape3D.queue_free()
	print("You can walk past")  # Debugging message after collision is removed

	# Hide or change the mesh visibility
	$MeshInstance3D.visible = false  # Optional to hide the mesh
