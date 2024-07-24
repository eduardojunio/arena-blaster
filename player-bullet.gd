extends Sprite2D

var speed = 0 # in pixels per second
var direction = Vector2.ZERO # Direction the bullet will travel

func _process(delta):
	global_position += direction * speed * delta
	if is_out_of_screen():
		queue_free()

func is_out_of_screen():
	return not get_viewport_rect().intersects(get_global_rect())

func get_global_rect():
	return Rect2(global_position - (get_size() / 2), get_size())

func get_size():
	return get_rect().size
