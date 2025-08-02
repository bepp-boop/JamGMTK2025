extends Area2D

@onready var raycast = $RayCast2D
@onready var rock_collision = $CollisionShape2D

var is_falling = false  # To check if the rock is falling
var fall_speed = 200  # Speed of falling
var fall_distance = 300  # Maximum distance the rock will fall
var destination = Vector2()  # Where the rock will fall to
var fall_direction = Vector2(0, 1)  # Direction to move (downwards)

# Function to check if RayCast2D has hit a CharacterBody2D
func check_raycast():
	# Ensure the ray is enabled and colliding
	if raycast.is_colliding():
		var collider = raycast.get_collider()  # Get the object that the ray collided with
		print("Collider:", collider)
		# Check if the collider is a CharacterBody2D
		if collider is CharacterBody2D:
			print("Ray hit the character!")
			start_wiggling()  # Start wiggling the rock

# Function to make the rock wiggle
func start_wiggling():
	print("Rock is wiggling!")
	print("50% chance of falling")

	# 50% chance to make the rock fall
	if randf_range(0, 100) < 50:  # Random number between 0 and 100
		start_falling()  # Make the rock fall if the condition is met

# Function to start falling
func start_falling():
	print("Rock is falling!")
	is_falling = true
	destination = position + fall_direction * fall_distance  # Calculate the destination

# Move the rock every frame if it is falling
func _process(delta: float) -> void:
	# Check if RayCast2D is hitting something and act accordingly
	check_raycast()

	if is_falling:
		# Move the rock toward the destination using delta for smooth frame-by-frame movement
		var move_step = fall_speed * delta  # How much the rock moves each frame
		position = position.move_toward(destination, move_step)
		
		# If the rock reaches the destination, stop the falling and queue it for removal
		if position.distance_to(destination) < move_step:
			queue_free()  # Remove the rock once it has reached the destination
			is_falling = false
