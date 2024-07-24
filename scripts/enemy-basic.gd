extends Node2D

@export var player: Node2D
@export var speed = 150

func _ready():
	rotation = get_direction().angle()

func _process(delta):
	move(delta)

func move(delta):
	if get_distance() < 5:
		return
	var direction = get_direction()
	global_position += direction * speed * delta
	rotation = lerp_angle(rotation, direction.angle(), 0.1)

func get_direction():
	return (player.get_sprite_position() - global_position).normalized()

func get_distance():
	return global_position.distance_to(player.get_sprite_position())
