extends Area2D

@export var damage = 10

@onready var sprite = $Sprite2D

var speed = 0 # in pixels per second
var direction = Vector2.ZERO # Direction the bullet will travel

func _physics_process(delta):
	global_position += direction * speed * delta
	if has_overlapping_bodies():
		for body in get_overlapping_bodies():
			if body.has_node("HealthComponent"):
				var health_component = body.get_node("HealthComponent")
				health_component.take_damage(damage)
	if is_out_of_screen() or has_overlapping_bodies():
		queue_free()

func is_out_of_screen():
	return not get_viewport_rect().intersects(get_global_rect())

func get_global_rect():
	return Rect2(global_position - (get_size() / 2), get_size())

func get_size():
	return sprite.get_rect().size
