extends Node2D

@onready var face: AnimatedSprite2D = $Solution/Face
@onready var solution_collision_shape: CollisionShape2D = $Solution/SolutionCollisionShape
@onready var player: CharacterBody3D 
@onready var switch_manager: Node3D =  get_tree().get_first_node_in_group("switch_manager")
@onready var give_item = $GiveItem

var correct_shapes_count = 0


func _ready() -> void:
	face.animation_finished.connect(finish_game)
	pass

func _process(delta: float) -> void:	
	print('number right: %s'% correct_shapes_count)
	if correct_shapes_count == 3:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		face.play("right")
	pass

func finish_game():
	var character_num = switch_manager.getState()
	print("deleting minigame for player %s" % character_num)
	player = get_tree().get_nodes_in_group("player")[character_num]
	give_item.give_item_to(player)
	player.end_minigame()	
	
	
func _on_solution_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	#print("puzzle piece placed: %s" % area.get_parent().name)
	var correct_shapes= ['DraggablePiece4','DraggablePiece2','DraggablePiece1']
	var current_shape_entered=area.get_parent().name
	if current_shape_entered in correct_shapes:
		correct_shapes_count += 1
	pass # Replace with function body.



func _on_solution_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var correct_shapes= ['DraggablePiece4','DraggablePiece2','DraggablePiece1']
	var current_shape_entered=area.get_parent().name
	if current_shape_entered in correct_shapes:
		correct_shapes_count -= 1
	pass # Replace with function body.
