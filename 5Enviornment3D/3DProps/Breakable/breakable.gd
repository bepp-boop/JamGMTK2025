extends StaticBody3D

var dead = false
@onready var breakable: StaticBody3D = $"."
@onready var box: MeshInstance3D = $Box
@onready var destroy_box: MeshInstance3D = $DestroyedBox
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var animate: AnimatedSprite2D = $Sprite2D  # Ensure this is AnimatedSprite2D

func _ready():
	animate.play("idletree")  # Play idle animation when spawned
	
func kill():
	if dead:
		return  # Prevent double-kill
	print("kill() method triggered")
	dead = true
	
	audio_stream_player_3d.play()  # Play death sound
	
	# Disable collisions
	breakable.collision_mask = 0
	breakable.collision_layer = 0
	
	print("You can walk past")
	
	# Change the sprite animation to a permanent death state
	animate.play("death")  # Make sure this animation exists
	animate.animation_finished.connect(_on_death_animation_finished)
	
func _on_death_animation_finished():
	# Stop the animation and set it to the last frame
	animate.stop()
	animate.frame = animate.sprite_frames.get_frame_count("death") - 1
