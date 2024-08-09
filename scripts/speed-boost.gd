extends Area2D

@export var speed_increase = 200 # in pixels per second

@onready var timer = $Timer
@onready var collision = $CollisionShape2D

var boosted_body = null

func _ready():
	body_entered.connect(increase_speed)
	timer.timeout.connect(decrease_speed)

func increase_speed(body):
	var movement_component = get_movement_component(body)
	if timer.is_stopped() and movement_component:
		movement_component.speed += speed_increase
		boosted_body = body
		timer.start()
		hide()

func decrease_speed():
	if boosted_body and is_instance_valid(boosted_body):
		var movement_component = get_movement_component(boosted_body)
		movement_component.speed -= speed_increase
		queue_free()

func get_movement_component(body):
	if body.has_node("MovementComponent"):
		return body.get_node("MovementComponent")
