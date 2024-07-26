class_name Enemy extends Node2D

@export var player: Player

@onready var health_component = $HealthComponent
@onready var movement_component = $MovementComponent

func _ready():
	health_component.on_damage.connect(handle_damage)
	movement_component.on_collision.connect(handle_collision)

func handle_damage(damage, current_health):
	if current_health == 0:
		queue_free()
	elif has_node("FlashingComponent"):
		$FlashingComponent.start_flashing()

func handle_collision(collision):
	if collision.get_collider() == player:
		player.get_node("HealthComponent").die()
