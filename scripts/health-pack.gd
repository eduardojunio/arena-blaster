extends Area2D

@export var health_increase = 100

func _ready():
	body_entered.connect(increase_health)

func increase_health(body):
	if body.has_node("HealthComponent"):
		body.get_node("HealthComponent").heal(health_increase)
		queue_free()
