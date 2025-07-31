extends Node3D

@onready var area = $Area3D
@export var collect_sound: AudioStream

func _ready():
	print("Collectible Ready!")  # Debug: Check if this script is running
	area.body_entered.connect(_on_body_entered)  # Connect the signal

# This function is triggered when any body enters the Area3D
func _on_body_entered(body):
	if body.name == "Player":  # Ensure the player's name is set to "Player"
		print("Collectible collected!")
		if collect_sound:
			var audio = AudioStreamPlayer3D.new()
			audio.stream = collect_sound
			add_child(audio)
			audio.play()
		queue_free()  # Remove the collectible after collection
