extends Node

@onready var check_zone = $Area3D
@onready var block_zone = $Area3D/CollisionShape3D
@onready var check_item = $CheckItem

func _ready():
	check_zone.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody3D:
		activate(body)

func activate(body: CharacterBody3D):
	if check_item.has_required_items(body):
		print("Thanks for:", check_item.required_items)
		# Example: block_zone.disabled = true
		# Trigger mechanism here
	else:
		print("Required items not found in inventory.")
