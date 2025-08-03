extends Node2D

var eyes_instanced = []
var number_of_eyes = 8
var poked_count = 0
@onready var eyes_Node: Node = $Eyes

@onready var worm_object: StaticBody3D = get_tree().get_first_node_in_group("worm")
@onready var player: CharacterBody3D 
@onready var switch_manager: Node3D =  get_tree().get_first_node_in_group("switch_manager")
@onready var give_item = $GiveItem


func _ready():
	poked_count = 0
	
	for i in range(number_of_eyes):
		var x_areaspawn=0.7*$TextureRect.size.x
		var y_areaspawn=0.7*$TextureRect.size.y
		var starting_x=randi_range($TextureRect.position.x+0.15*$TextureRect.size.x,$TextureRect.position.x+0.8*$TextureRect.size.x)
		var starting_y=randi_range($TextureRect.position.y+0.15*$TextureRect.size.y,$TextureRect.position.y+0.8*$TextureRect.size.y)
		var startingVector = Vector2(starting_x,starting_y)
		var eye_scene = load("res://3Minigames/EyePoker/Eye.tscn")
		var eye_instance = eye_scene.instantiate()
		eye_instance.position = startingVector
		var scalefactor = randf_range(0.2,0.7)
		eye_instance.scale = Vector2(scalefactor,scalefactor)
		eyes_Node.add_child(eye_instance)
		
		
func finish_game():
	worm_object.visible = false
	worm_object.get_child(1).disabled = true
	var character_num = switch_manager.getState()
	print("deleting minigame for player %s" % character_num)
	player = get_tree().get_nodes_in_group("player")[character_num]
	give_item.give_item_to(player)
	player.end_minigame()	
	
func count_poke():
	poked_count += 1
	print("poked count %s" % poked_count)
	if poked_count == number_of_eyes:
		print("got them all")
		finish_game()
	
