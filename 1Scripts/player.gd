extends CharacterBody3D

@onready var animated_sprite_2d = $CanvasLayer/GunBase/AnimatedSprite2D
@onready var ray_cast_3d = $RayCast3D
@onready var shoot_sound = $ShootSound
@onready var minigame: Control = $CanvasMinigame/Minigame
@onready var player_face: AnimatedSprite2D = $CanvasLayer/ClownName/PlayerFace

var minigame_instance

const SPEED = 5.0
const MOUSE_SENSITIVITY = 0.5

var input_disabled = false  # Track if input is disabled
var can_shoot = true
var dead = false

var inventory = []
var game_mode = 'FPS' ##

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	animated_sprite_2d.animation_finished.connect(shoot_animation_done)
	$CanvasLayer/DeathScreen/Panel/Restart.button_up.connect(restart)

func set_input_disabled(state: bool):
	# Set the input disabled state for this player
	input_disabled = state

func _input(event):
	if dead or input_disabled:
		return  # Ignore input if player is dead or input is disabled
	
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * MOUSE_SENSITIVITY

func _process(delta: float) -> void:
	if dead:
		return
	if input_disabled:
		return
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		restart()
	if Input.is_action_just_pressed("shoot"):
		shoot()
	if Input.is_action_just_pressed("debugbutton"):
		print("debug activated")
		start_minigame()

func _physics_process(delta: float):
	if dead or input_disabled:
		return
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()

func shoot():
	if !can_shoot:
		return
	can_shoot = false
	animated_sprite_2d.play("shoot")
	player_face.play("shoot")
	shoot_sound.play()
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("kill"):
		print("hit collider of"+ray_cast_3d.get_collider().name)
		ray_cast_3d.get_collider().kill()
	
func has_item(item_name: String) -> bool:
	return inventory.has(item_name)  # assuming `inventory` is a Dictionary or Array

func shoot_animation_done():
	can_shoot = true

func add_item(item_name: String):
	print("Picked up:", item_name)
	inventory.append(item_name)
	
func kill():
	dead = true
	$CanvasLayer/DeathScreen.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func finish_player():
	var controller = get_parent()
	if controller and controller.has_method("finish_player"):
		controller.finish_player(self)
	else:
		push_warning("Controller not found or doesn't have finish_player() method.")

func restart():
	get_tree().reload_current_scene()
	
func start_minigame(minigamename = "EyePoker"):
	print("minigame started: %s" % minigamename)
	$CanvasMinigame.show()
	$CanvasLayer.hide()
	set_input_disabled(true)
	var minigame_chosen = load("res://Minigames/%s/%s.tscn" % [minigamename, minigamename])
	minigame_instance = minigame_chosen.instantiate()
	minigame.add_child(minigame_instance)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func end_minigame():
	print("minigame closed")
	set_input_disabled(false)
	$CanvasMinigame.hide()
	$CanvasLayer.show()
	minigame_instance.queue_free()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
