class_name Enemy extends CharacterBody2D

@export var player: Player

func _on_damage(damage, current_health):
	if current_health == 0:
		queue_free()
