extends Node3D

@onready var audio_stream_player_3d: AudioStreamPlayer3D = $"../AudioStreamPlayer3D"


func activateMinigame():
	#Worm dies after poking
	#$CollisionShape3D.disabled=true
	#$WormMesh.visible=false
	return "FingerPuzzle"
