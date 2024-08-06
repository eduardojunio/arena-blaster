class_name Shield
extends Area2D

@onready var pickup = $Pickup
@onready var effect = $Effect
@onready var timer = $Timer

var shielded_body = null

func _ready():
	body_entered.connect(shield)
	timer.timeout.connect(remove_shield)

func _process(delta):
	effect.rotation += (PI / 4) * delta

func shield(body):
	var health_component = get_health_component(body)

	if ("remote_transform_2d" in body) and has_node(body.remote_transform_2d.remote_path) and get_node(body.remote_transform_2d.remote_path) is Shield:
		get_node(body.remote_transform_2d.remote_path).timer.start()
		queue_free()
	elif timer.is_stopped() and ("remote_transform_2d" in body) and health_component and health_component.can_take_damage:
		health_component.can_take_damage = false
		body.remote_transform_2d.remote_path = get_path()
		shielded_body = body
		pickup.hide()
		effect.show()
		timer.start()

func remove_shield():
	get_health_component(shielded_body).can_take_damage = true
	shielded_body.remote_transform_2d.remote_path = NodePath("")
	queue_free()

func get_health_component(body):
	if body.has_node("HealthComponent"):
		return body.get_node("HealthComponent")
