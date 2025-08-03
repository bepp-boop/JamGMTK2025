extends Area2D

var is_dragging = false #state management
var offset = Vector2(0,0)
@export var piecenumber=1

func _ready() -> void:
	get_viewport().set_physics_object_picking_sort(true)
	get_viewport().set_physics_object_picking_first_only(true)
	$AnimatedSprite2D3.play("piece%s" % piecenumber)



func _unhandled_input(event):
	if event is InputEventMouseButton and not event.pressed:
		is_dragging = false
	if is_dragging and event is InputEventMouseMotion:
		position += event.relative

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("clicking object %s" % name)
		is_dragging = true
		
