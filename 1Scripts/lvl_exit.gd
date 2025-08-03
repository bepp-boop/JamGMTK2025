extends Node 


@onready var switch_manager = get_tree().get_first_node_in_group("switch_manager")
@onready var area = $AnimatedSprite3D/Area3D
@export var required_items: Array[String] = ["key"]
@export var require_all: bool = true  # If false, any one item is enough


func _ready():
	area.body_entered.connect(_on_body_entered)
	

func _on_body_entered(body: Node):	
	var character_num = switch_manager.getState()  # Get the active character number (state)
	print("giving food to baby")
	var player = get_tree().get_nodes_in_group("player")[character_num]
	if body is CharacterBody3D and body.get_parent().has_method("finish_player"):
		print("You exist")
		body.get_parent().finish_player(body)
		print("Player finished their part at the door.")


func _on_area_3d_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	var character_num = switch_manager.getState()  # Get the active character number (state)
	var player = get_tree().get_nodes_in_group("player")[character_num]
	if body.get_parent().has_method("finish_player") :
		print("You exist")
		body.get_parent().finish_player(body)
		print("Player finished their part at the door.")
	pass # Replace with function body.
