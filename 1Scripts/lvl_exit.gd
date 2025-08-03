extends Node3D

@onready var area = $AnimatedSprite3D/Area3D

func _ready():
	area.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node):
	if body is CharacterBody3D and body.get_parent().has_method("finish_player"):
		print("You exist")
		body.get_parent().finish_player(body)
		print("Player finished their part at the door.")
