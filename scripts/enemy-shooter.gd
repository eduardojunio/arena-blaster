class_name EnemyShooter extends Enemy

@export var bullet: PackedScene
@export var bullet_speed = 750

@onready var cooldown: Timer = $Cooldown
@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(_delta):
	shoot()

func get_size():
	return sprite.get_rect().size

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
