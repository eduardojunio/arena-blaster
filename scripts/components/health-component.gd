class_name HealthComponent extends Node2D

signal on_health_change(value, current_health)

@export var max_health = 100
@export var current_health = 100

func _ready():
	assert(current_health <= max_health)

func take_damage(value):
	current_health = max(current_health - value, 0)
	on_health_change.emit(-value, current_health)

func heal(value):
	current_health = min(current_health + value, max_health)
	on_health_change.emit(value, current_health)

func get_health_percentage():
	return (current_health / float(max_health)) * 100

func die():
	take_damage(current_health)
