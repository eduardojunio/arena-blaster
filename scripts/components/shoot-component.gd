extends Node2D

@export var target: Sprite2D
@export var input_component: InputComponent
@export var cooldown_time = 0.1
@export var bullet: PackedScene
@export var bullet_speed = 1500 # in pixels per second
@export var bullet_offset = 10

@onready var cooldown = $Cooldown

func _process(_delta):
	update_wait_time()
	if input_component.is_shooting():
		shoot()

func shoot():
	if is_on_cooldown():
		return

	var bullet_instance = bullet.instantiate()
	get_tree().root.add_child(bullet_instance)

	var bullet_direction = get_bullet_direction()
	bullet_instance.direction = bullet_direction
	bullet_instance.speed = bullet_speed
	bullet_instance.rotation = bullet_direction.angle()
	var target_size_offset = (get_target_size().x / 2) * bullet_direction
	var bullet_size_offset = (bullet_instance.get_size().x / 2) * bullet_direction
	var extra_offset = bullet_offset * bullet_direction
	bullet_instance.global_position = target.global_position + target_size_offset + bullet_size_offset + extra_offset
	cooldown.start()

func get_target_size():
	return target.get_rect().size

func get_bullet_direction():
	return (input_component.get_look_target() - target.global_position).normalized()

func is_on_cooldown():
	return not cooldown.is_stopped()

func update_wait_time():
	if cooldown.wait_time != cooldown_time:
		cooldown.wait_time = cooldown_time
