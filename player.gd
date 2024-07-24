extends Node2D

@export var health_bar: ProgressBar
@export var sprite: Sprite2D
@export var cooldown: Timer
@export var bullet: PackedScene
@export var speed = 400 # in pixels per second
@export var bullet_speed = 1500 # in pixels per second
@export var max_health = 300
@export var current_health = 300

var shooting = false

func _ready():
	update_health_bar()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_sprite(event.position)
	if event is InputEventMouseButton:
		shooting = event.pressed

func _process(delta):
	move(delta)
	if shooting:
		shoot(get_global_mouse_position())

func update_health_bar():
	health_bar.max_value = max_health
	health_bar.value = current_health

func take_damage(value):
	current_health = max(current_health - value, 0)
	update_health_bar()

func move(delta):
	position += get_motion() * speed * delta
	clamp_position()
	rotate_sprite(get_global_mouse_position())

func clamp_position():
	var min_position = get_sprite_size() / 2
	var max_position = get_viewport_size() - (get_sprite_size() / 2)
	position = position.clamp(min_position, max_position)

func get_motion():
	var result = Vector2.ZERO
	if Input.is_action_pressed("up"):
		result.y -= 1
	if Input.is_action_pressed("down"):
		result.y += 1
	if Input.is_action_pressed("left"):
		result.x -= 1
	if Input.is_action_pressed("right"):
		result.x += 1
	return result.normalized()

func get_sprite_size():
	return sprite.get_rect().size

func get_viewport_size():
	return get_viewport().get_visible_rect().size

func rotate_sprite(target_position):
	sprite.rotation = get_direction_rotation(get_sprite_direction(target_position))

func shoot(target_position):
	if not cooldown.is_stopped():
		return

	var bullet_instance = bullet.instantiate()
	get_parent().add_child(bullet_instance)

	var bullet_direction = get_sprite_direction(target_position)
	bullet_instance.direction = bullet_direction
	bullet_instance.speed = bullet_speed
	bullet_instance.rotation = get_direction_rotation(bullet_direction)
	var bullet_size_offset = (bullet_instance.get_size().x / 2) * bullet_direction
	var extra_offset = 10 * bullet_direction
	bullet_instance.global_position = sprite.global_position + (bullet_direction * get_sprite_radius()) + bullet_size_offset + extra_offset

	cooldown.start()

func get_sprite_direction(target_position):
	return (target_position - sprite.global_position).normalized()

func get_direction_rotation(direction):
	return Vector2.RIGHT.angle_to(direction)

func get_sprite_radius():
	return get_sprite_size().x / 2
