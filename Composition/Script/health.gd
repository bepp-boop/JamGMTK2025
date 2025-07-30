extends Node2D
class_name HealthComponent


@export var MaxHealth := 10.0
var health : float

@export var health_bar : ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	health = MaxHealth

	if health_bar:
		health_bar.max_value = MaxHealth
		health_bar.value = health
		
func damage(attack: Attack):
	health -= attack.damage_value
	
	if health <= 0:
		get_parent().queue_free()
	
	if health_bar:
		health_bar.value = health
