class_name Enemy extends Node2D

@export var player: Player
@export var health_pack: PackedScene
@export var health_pack_chance = 0 # in percentage
@export var health_pack_critical_chance = 0 # in percentage

@onready var health_component = $HealthComponent
@onready var movement_component = $MovementComponent

func _ready():
	assert(health_pack_chance <= health_pack_critical_chance)
	health_component.on_health_change.connect(handle_health_change)
	movement_component.on_collision.connect(handle_collision)

func handle_health_change(value, current_health):
	if current_health == 0:
		if should_spawn_health_pack():
			spawn_health_pack()
		queue_free()
	elif has_node("FlashingComponent"):
		$FlashingComponent.start_flashing()

func handle_collision(collision):
	if collision.get_collider() == player:
		player.get_node("HealthComponent").die()

func should_spawn_health_pack():
	return randf() < (get_health_pack_chance() / 100.0)

func get_health_pack_chance():
	var player_health_percentage = player.get_node("HealthComponent").get_health_percentage()
	if player_health_percentage <= 25:
		return health_pack_critical_chance
	else:
		return health_pack_chance

func spawn_health_pack():
	var health_pack_instance = health_pack.instantiate()
	health_pack_instance.global_position = global_position
	get_tree().root.add_child(health_pack_instance)
