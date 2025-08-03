extends Node3D

#this is the hungry baby.
#you give him the fork to escape.

@export var required_items: Array[String] = ["fork"]
@export var require_all: bool = true  # If false, any one item is enough
@onready var receive_sound: AudioStreamPlayer3D = $receive_sound

@onready var switch_manager: Node3D = get_tree().get_first_node_in_group("switch_manager")  # Switch Manager to get the state
@onready var area = $Area3D
@onready var give_item = $GiveItem


func activateInteractable():
	
	var character_num = switch_manager.getState()  # Get the active character number (state)
	print("giving food to baby")
	var player = get_tree().get_nodes_in_group("player")[character_num]
	if has_required_items(player):
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
