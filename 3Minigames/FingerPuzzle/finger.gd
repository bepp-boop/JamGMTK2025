extends CharacterBody2D

@onready var player: CharacterBody3D 
@onready var switch_manager: Node3D =  get_tree().get_first_node_in_group("switch_manager")

# Variables to control movement speed and direction
const SPEED = 130  # Speed when moving right
const SLOW_SPEED = 60  # Slow speed when moving back

var original_position : Vector2  # To store the original position of the character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_position = position  # Store the initial position when the scene starts

# Called every frame
func _process(delta: float) -> void:
	# If the spacebar is pressed, move right
	if Input.is_action_pressed("ui_select"):
		velocity.x = SPEED  # Move towards the right
	else:
		# Slowly move backward when the spacebar is released
		if position.x > original_position.x:
			velocity.x = -SLOW_SPEED  # Move left towards the original position
		else:
			velocity.x = 0  # Stop when the original position is reached

	# Move the character with the current velocity
	move_and_slide()

	# Stop the character once it's moving very slowly or it has reached the original position
	if abs(velocity.x) < 1:
		velocity.x = 0  # Stop moving once the velocity is small enough


func finish_game():
	var character_num = switch_manager.getState()
	print("deleting minigame for player %s" % character_num)
	player = get_tree().get_nodes_in_group("player")[character_num]
	player.end_minigame()	

func _on_button_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:  # Ensure the body is of type CharacterBody2D
		print("Game Done give special Item")
		
		
func _on_fall_rock_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("Game Lost")
