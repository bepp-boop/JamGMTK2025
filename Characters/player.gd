extends CharacterBody3D

@onready var animated_sprite_2d = $CanvasLayer/GunBase/AnimatedSprite2D
@onready var ray_cast_3d = $RayCast3D
@onready var shoot_sound = $ShootSound

const SPEED = 5.0
const MOUSE_SENSITIVITY = 0.5

var input_disabled = false  # Track if input is disabled
var can_shoot = true
var dead = false

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
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		restart()
	if Input.is_action_just_pressed("shoot"):
		shoot()

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
	shoot_sound.play()
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("kill"):
		print("hit collider of"+ray_cast_3d.get_collider().name)
		ray_cast_3d.get_collider().kill()
	

func shoot_animation_done():
	can_shoot = true


func kill():
	dead = true
	$CanvasLayer/DeathScreen.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func restart():
	get_tree().reload_current_scene()
