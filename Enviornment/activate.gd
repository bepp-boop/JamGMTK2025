extends Node

@export var requirement: String = "default_item"
@onready var check_zone = $Area3D
@onready var block_zone = $Area3D/CollisionShape3D

func _ready():
	check_zone.body_entered.connect(_on_body_entered)	

func _on_body_entered(body):
	# Ensure it's a character body (optional but recommended)
	if body is CharacterBody3D:
		activate(body)

func activate(body: CharacterBody3D):
	if body.has_variable("inventory"):
		for item in body.inventory:
			if item == requirement:
				print("Thanks for :", requirement)
				# You can trigger something here (e.g. open door, activate mechanism)
				
		print("Required item not found in inventory.")
	else:
		print("Body has no 'inventory' variable.")
