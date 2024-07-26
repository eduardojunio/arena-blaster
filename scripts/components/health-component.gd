class_name HealthComponent extends Node2D

signal on_damage(damage, current_health)

@export var max_health = 100
@export var current_health = 100

func take_damage(value):
	current_health = max(current_health - value, 0)
	on_damage.emit(value, current_health)

func die():
	take_damage(current_health)
