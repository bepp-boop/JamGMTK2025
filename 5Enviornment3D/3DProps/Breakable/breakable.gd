extends StaticBody3D

var dead = true
@onready var breakable: StaticBody3D = $"."
@onready var box: MeshInstance3D = $Box
@onready var destroy_box: MeshInstance3D = $DestroyedBox
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var animated_sprite_3d: AnimatedSprite3D = $AnimatedSprite3D

@onready var stick: Node3D =  get_tree().get_first_node_in_group("stick")



func _ready():
	if dead:
		animated_sprite_3d.play("death")
	else:
		animated_sprite_3d.play("idletree")  # Play idle animation when spawned
		
func _physics_process(delta: float) -> void:
	if dead:
		animated_sprite_3d.play("death")
	else:
		animated_sprite_3d.play("idletree")  # Play idle animation when spawned
	
func activateInteractable():	
	if dead:
		return  # Prevent double-kill
	print("kill() method triggered")
	dead = true
	stick.visible = true
	stick.get_child(0).monitoring = true
	
	audio_stream_player_3d.play()  # Play death sound
	
	# Disable collisions
	breakable.collision_mask = 0
	breakable.collision_layer = 0
	
	print("You can walk past")
	
	# Change the sprite animation to a permanent death state
	animated_sprite_3d.animation = "death"
	animated_sprite_3d.frame = 0  # or whichever frame you want
	animated_sprite_3d.stop() # Make sure this animation exists
	
