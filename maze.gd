extends Node2D

@onready var character = $"2DPlayer"  # Reference to the 2DPlayer node (CharacterBody2D)
@onready var key = $Area2D            # Reference to the Area2D that triggers the event
@onready var switch_manager: Node3D = get_tree().get_first_node_in_group("switch_manager")  # Switch Manager to get the state
@onready var give_item = $GiveItem


var player: CharacterBody3D  # We'll get the player instance when needed

# Called when the body enters the Area2D
func _ready():
	# Ensure the Area2D is monitoring bodies
	key.monitoring = true
	key.monitorable = true

# Finish the game for the current player (based on switch_manager state)
func finish_game():
	var character_num = switch_manager.getState()  # Get the active character number (state)
	print("deleting minigame for player %s" % character_num)
	
	# Find the player in the "player" group and call end_minigame() for them
	player = get_tree().get_nodes_in_group("player")[character_num]
	# Give a specific item to player
	give_item.give_item_to(player)
	player.end_minigame()	

# This function is used to manually check if the player enters the area
func _process(delta):
	# Check if the player character overlaps the Area2D
	if key.get_overlapping_bodies().has(character):
		finish_game()  # Call finish_game when 2DPlayer enters the area
