class_name Player extends Node2D

@onready var health_bar = $HealthBar
@onready var health_component = $HealthComponent
@onready var sprite = $Sprite

func _ready():
	health_component.on_health_change.connect(_on_health_change)
	update_health_bar()

func update_health_bar():
	health_bar.max_value = health_component.max_health
	health_bar.value = health_component.current_health

func get_sprite_position():
	return sprite.global_position

func _on_health_change(value, current_health):
	update_health_bar()
	if current_health == 0:
		hide()
