extends Sprite2D

var speed = 300 # in pixels per second

func _input(event):
	if event is InputEventMouseButton:
		print()

func _process(delta):
	move(delta)

func move(delta):
	position += get_motion() * speed * delta
	clamp_position()

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
	return get_viewport_rect().size
