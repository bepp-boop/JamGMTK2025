
extends Node3D

# Ensure correct node paths (modify if necessary)
@onready var player1 = get_node("Player1")  # Reference to Player 1 Node
@onready var player2 = get_node("Player2")  # Reference to Player 2 Node
@onready var player3 = get_node("Player3")  # Reference to Player 3 Node

@onready var player1HUD = get_node("Player1/CanvasLayer")  # Reference to Player 1 HUD
@onready var player2HUD  = get_node("Player2/CanvasLayer")  # Reference to Player 2 HUD
@onready var player3HUD  = get_node("Player3/CanvasLayer")  # Reference to Player 3 HUD

@onready var camera1 = get_node("Player1/Camera3D")  # Camera attached to Player 1
@onready var camera2 = get_node("Player2/Camera3D")  # Camera attached to Player 2
@onready var camera3 = get_node("Player3/Camera3D")  # Camera attached to Player 3

@onready var statusTag1 = get_node("Player1/CanvasLayer/ClownName/Label")  # Label for Player 1
@onready var statusTag2 = get_node("Player2/CanvasLayer/ClownName/Label")  # Label for Player 2
@onready var statusTag3 = get_node("Player3/CanvasLayer/ClownName/Label")  # Label for Player 3

@onready var face1 = get_node("Player1/CanvasLayer/ClownName/PlayerFace")  # Label for Player 1
@onready var face2 = get_node("Player2/CanvasLayer/ClownName/PlayerFace")  # Label for Player 2
@onready var face3 = get_node("Player3/CanvasLayer/ClownName/PlayerFace")  # Label for Player 3

var max_time = 1.0
var time_left = 0.0
var can_change = false

enum {CHAR_1, CHAR_2, CHAR_3}
var state



# Called when the node enters the scene tree for the first time.
func _ready():
	time_left = max_time
	state = CHAR_1

	# Set initial states
	player1.visible = true
	player2.visible = false
	player3.visible = false
	
	# Set initial states hud
	player1HUD.visible = true
	player2HUD.visible = false
	player3HUD.visible = false
	
	# Set all cameras to be initially off (not active)
	camera1.current = true
	camera2.current = false
	camera3.current = false
	
	# Initially disable input for players 2 and 3
	player1.set_input_disabled(false)  # Player 1 gets input
	player2.set_input_disabled(true)   # Disable Player 2 input
	player3.set_input_disabled(true)   # Disable Player 3 input

	# Initially update the label for player 1
	statusTag1.text = "1"
	statusTag2.text = ""
	statusTag3.text = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if time_left > 0.0:
		time_left -= delta
		print(time_left)
	elif time_left <= 0.0 and can_change == false:
		print("Can now change characters")
		can_change = true
	
	match state:
		CHAR_1:
			if Input.is_action_just_pressed("ui_accept") and can_change == true:
				state = CHAR_2
				print(state)
				print("char 2 active")
				_switch_to_player(player2)
				reset_char_switch_delay()
		CHAR_2:
			if Input.is_action_just_pressed("ui_accept") and can_change == true:
				state = CHAR_3
				print(state)
				print("char 3 active")
				_switch_to_player(player3)
				reset_char_switch_delay()
		CHAR_3:
			if Input.is_action_just_pressed("ui_accept") and can_change == true:
				state = CHAR_1
				print(state)
				print("char 1 active")
				_switch_to_player(player1)
				reset_char_switch_delay()

func reset_char_switch_delay():
	time_left = max_time
	can_change = false

# Function to handle switching to a new player
func _switch_to_player(new_player):
	# Deactivate all players' cameras
	camera1.current = false
	camera2.current = false
	camera3.current = false
	
	# Deactivate all players (hide them)
	player1.visible = false
	player2.visible = false
	player3.visible = false
	
	# Deactivate all players HUD(hide them)
	player1HUD.visible = false
	player2HUD.visible = false
	player3HUD.visible = false
	
	# Disable input for all players
	player1.set_input_disabled(true)
	player2.set_input_disabled(true)
	player3.set_input_disabled(true)

	# Activate the new player and its camera
	new_player.visible = true
	var new_player_HUD= new_player.find_child('CanvasLayer')
	new_player_HUD.visible=true
	if new_player == player1:
		camera1.current = true
		player1.set_input_disabled(false)  # Enable input for Player 1
		statusTag1.text = "1"  # Update the label for Player 1
		statusTag2.text = ""   # Clear label for Player 2
		statusTag3.text = ""   # Clear label for Player 3
	elif new_player == player2:
		camera2.current = true
		player2.set_input_disabled(false)  # Enable input for Player 2
		statusTag1.text = ""   # Clear label for Player 1
		statusTag2.text = "2"  # Update the label for Player 2
		statusTag3.text = ""   # Clear label for Player 3
	elif new_player == player3:
		camera3.current = true
		player3.set_input_disabled(false)  # Enable input for Player 3
		statusTag1.text = ""   # Clear label for Player 1
		statusTag2.text = ""   # Clear label for Player 2
		statusTag3.text = "3"  # Update the label for Player 3

func getState():
	return state
