extends Node3D

@onready var player1 = %Player  # Reference to Player1 node
@onready var player2 = %Player2  # Reference to Player2 node
@onready var player3 = %Player3  # Reference to Player3 node

var current_player = 1  # 1 = Player1, 2 = Player2, 3 = Player3

func _ready():
	# Set initial player states
	player1.set_input_disabled(false)  # Player1 can move
	player2.set_input_disabled(true)   # Player2 can't move
	player3.set_input_disabled(true)   # Player3 can't move

func _input(event):
	# Listen for the "ui_select" (default is Enter/Space) to switch players
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_TAB:  # Check if the TAB key was pressed
			_on_switch_key_pressed()

# Switch input control between Player1, Player2, and Player3
func _on_switch_key_pressed():
	if current_player == 1:
		player1.set_input_disabled(true)  # Disable Player1's input
		player2.set_input_disabled(false) # Enable Player2's input
		current_player = 2
	elif current_player == 2:
		player2.set_input_disabled(true)  # Disable Player2's input
		player3.set_input_disabled(false) # Enable Player3's input
		current_player = 3
	else:
		player3.set_input_disabled(true)  # Disable Player3's input
		player1.set_input_disabled(false) # Enable Player1's input
		current_player = 1
