extends StaticBody3D

var dead = false
@onready var breakable: StaticBody3D = $"."
@onready var box: MeshInstance3D = $Box
@onready var destroy_box: MeshInstance3D = $DestroyedBox
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D



func kill():
	print("kill() method triggered")  # Debugging message to confirm it's called
	dead = true
	audio_stream_player_3d.play()  # Play the audio
	
	# Delete collision so player can pass through
	breakable.collision_mask = 0 #delete the collision mask
	breakable.collision_layer = 0 #delete the collision layer
	
	print("You can walk past")  # Debugging message after collision is removed

	# Hide or change the mesh visibility
	box.visible = false  # Hide Full object
	destroy_box.visible = true  # Show destroyed Object
