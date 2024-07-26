class_name MovementComponent extends Node2D

signal on_collision(collision)

@export var target: CharacterBody2D
@export var input_component: InputComponent
@export var speed = 100 # in pixels per second
@export var target_size: Vector2 # required to prevent the target from leaving the screen
@export var stop_on_collision = false

var collided = false

func _process(_delta):
	if not collided or not stop_on_collision:
		target.velocity = input_component.get_direction() * speed
		collided = target.move_and_slide()
		if collided:
			on_collision.emit(target.get_last_slide_collision())
		clamp_position()

func clamp_position():
	var min_position = target_size / 2
	var max_position = get_viewport_size() - (target_size / 2)
	target.global_position = target.global_position.clamp(min_position, max_position)

func get_viewport_size():
	return get_viewport().get_visible_rect().size
