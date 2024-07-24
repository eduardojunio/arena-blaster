extends CharacterBody2D

@export var player: Node2D
@export var bullet: PackedScene
@export var speed = 75 # in pixels per second
@export var bullet_speed = 750

@onready var cooldown: Timer = $Cooldown
@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	rotation = get_direction_to_player().angle()

func _physics_process(delta):
	shoot()
	velocity = get_direction_to_player() * speed
	rotation = lerp_angle(rotation, get_direction_to_player().angle(), 0.05)
	if global_position.distance_to(player.global_position) < 100:
		return
	move_and_slide()

func get_direction_to_player():
	return get_direction(player.global_position)

func get_direction(target_position):
	return (target_position - global_position).normalized()

# TODO: Duplication
func shoot():
	if not cooldown.is_stopped():
		return

	var bullet_instance = bullet.instantiate()
	get_parent().add_child(bullet_instance)

	var bullet_direction = transform.x
	bullet_instance.direction = bullet_direction
	bullet_instance.speed = bullet_speed
	bullet_instance.rotation = bullet_direction.angle()
	var sprite_offset = (get_size().x / 2) * bullet_direction
	var bullet_size_offset = (bullet_instance.get_size().x / 2) * bullet_direction
	var extra_offset = 10 * bullet_direction
	bullet_instance.global_position = global_position + sprite_offset + bullet_size_offset + extra_offset

	cooldown.start()

func get_size():
	return sprite.get_rect().size
