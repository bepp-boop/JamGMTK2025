extends Node2D

var isPoked 
var pos_x
var pos_y


func _ready():
	$AnimatedSprite2D.play("blinking")
	isPoked=false

func poke():
	$AnimatedSprite2D.play('poked')
	isPoked=true
	
