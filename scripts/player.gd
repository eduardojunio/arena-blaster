class_name Player extends Node2D

@export var sprite: Sprite2D
@export var health_bar: ProgressBar
@export var health_component: HealthComponent

func _ready():
	update_health_bar()

func update_health_bar():
	health_bar.max_value = health_component.max_health
	health_bar.value = health_component.current_health

func get_sprite_position():
	return sprite.global_position

func _on_damage(damage, current_health):
	update_health_bar()
