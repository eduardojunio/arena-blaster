class_name EnemyBasic extends CharacterBody2D

@export var player: Node2D
@export var speed = 125 # in pixels per second

var rotation_step = 0.1 # how fast it rotates towards the player
var distance_to_keep_from_player = 100

func _ready():
	rotation = get_player_direction().angle()

func _physics_process(delta):
	velocity = get_player_direction() * speed
	rotation = lerp_angle(rotation, get_player_direction().angle(), rotation_step)
	if get_player_distance() > distance_to_keep_from_player:
		move_and_slide()

func get_player_direction():
	return get_direction(player.get_sprite_position())

func get_player_distance():
	return get_distance(player.get_sprite_position())

func get_direction(target_position):
	return (target_position - global_position).normalized()

func get_distance(target_position):
	return global_position.distance_to(target_position)
