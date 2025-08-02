extends Node2D

var isPoked 
var pos_x
var pos_y


@onready var eye_poker: Node2D =  get_tree().get_first_node_in_group("EyePoker")

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready():
	$AnimatedSprite2D.play("blinking")
	isPoked=false

func _process(delta: float) -> void:
	if isPoked:
		return
	

func poke():
	$AnimatedSprite2D.play('poked')
	eye_poker.count_poke()
	queue_free()
	isPoked=true
	


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("poked one")
		poke()
