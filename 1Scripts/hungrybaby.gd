extends Node3D

#this is the hungry baby.
#you give him the fork to escape.

@export var required_items: Array[String] = ["fork"]
@export var require_all: bool = true  # If false, any one item is enough
@onready var receive_sound: AudioStreamPlayer3D = $receive_sound


@onready var area = $AnimatedSprite3D/StaticBody3D/CollisionShape3D
@onready var give_item = $GiveItem

func _ready():
	area.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if has_required_items(body):
		var burger_walls = get_tree().get_nodes_in_group("burgerwall")
		for wall in burger_walls:
			wall.queue_free()
		print("item added from composition")
		if receive_sound:
			var audio = AudioStreamPlayer3D.new()
			audio.stream = receive_sound
			add_child(audio)
			audio.play()

func has_required_items(target: Node) -> bool:
	if target is CharacterBody3D and target.has_method("has_item"):
		if require_all:
			for item in required_items:
				if not target.has_item(item):
					return false
			return true
		else:
			for item in required_items:
				if target.has_item(item):
					return true
			return false
	else:
		push_warning("Target does not support inventory checking.")
		return false
