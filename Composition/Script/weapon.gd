extends Node2D

var attack_damage := 10.0
var knockback_force := 100.0


func _on_hitbox_body_entered(body: Node2D):
		if body.has_method("damage"):
			print("Damage Dealt")
			body.damage(attack_damage)
