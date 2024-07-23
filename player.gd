extends Sprite2D

var PlayerBullet = preload("res://player-bullet.tscn")

var speed = 400 # in pixels per second
var shooting = false

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_sprite(event.position)
	if event is InputEventMouseButton:
		shooting = event.pressed

func _process(delta):
	move(delta)
	if shooting:
		shoot(get_global_mouse_position())

func move(delta):
	position += get_motion() * speed * delta
	clamp_position()
	rotate_sprite(get_global_mouse_position())

func clamp_position():
	var min = get_size() / 2
	var max = get_viewport_size() - (get_size() / 2)
	position = position.clamp(min, max)

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

func get_size():
	return get_rect().size

func get_viewport_size():
	return get_viewport().get_visible_rect().size

func rotate_sprite(target_position):
	rotation = get_direction_rotation(get_direction(target_position))

func shoot(target_position):
	var cooldown = $Cooldown

	if not cooldown.is_stopped():
		return

	var bullet_instance = PlayerBullet.instantiate()
	get_parent().add_child(bullet_instance)

	var bullet_direction = get_direction(target_position)
	bullet_instance.direction = bullet_direction
	bullet_instance.rotation = get_direction_rotation(bullet_direction)
	var bullet_size_offset = (bullet_instance.get_size().x / 2) * bullet_direction
	var extra_offset = 10 * bullet_direction
	bullet_instance.global_position = global_position + (bullet_direction * get_radius()) + bullet_size_offset + extra_offset

	cooldown.start()

func get_direction(target_position):
	return (target_position - global_position).normalized()

func get_direction_rotation(direction):
	return Vector2.RIGHT.angle_to(direction)

func get_radius():
	return get_size().x / 2
