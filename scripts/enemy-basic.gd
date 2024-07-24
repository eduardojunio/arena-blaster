extends CharacterBody2D

@export var player: Node2D
@export var speed = 125

func _ready():
	rotation = get_player_direction().angle()

func _physics_process(delta):
	velocity = get_player_direction() * speed
	rotation = lerp_angle(rotation, get_player_direction().angle(), 0.1)
	if get_player_distance() > 100:
		move_and_slide()

# TODO: Duplication
func get_player_direction():
	return get_direction(player.get_sprite_position())

func get_player_distance():
	return get_distance(player.get_sprite_position())

# TODO: Duplication
func get_direction(target_position):
	return (target_position - global_position).normalized()

func get_distance(target_position):
	return global_position.distance_to(target_position)
