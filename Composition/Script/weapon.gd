extends Node2D

var attack_damage_value := 10.0
var knockback_force := 100.0
var stun_time := 1.5

func _on_hitbox_body_entered(area):
	if area is HitBoxComponent:
		var hitbox : HitBoxComponent = area
		
		var attack = Attack.new()
		attack.attack_damage = attack_damage_value
		print("Attack")
		hitbox.damage(attack)
