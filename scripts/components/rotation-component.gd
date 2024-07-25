class_name RotationComponent extends Node2D

@export var target: Node2D
@export var input_component: InputComponent
@export var smooth = false

func _ready():
	target.rotation = get_direction().angle()

func _process(delta):
	target.rotation = lerp_angle(target.rotation, get_direction().angle(), 0.1 if smooth else 1)

func get_direction():
	return input_component.get_look_target() - target.global_position
