extends Node2D

func _ready():
	set_crosshair()

func set_crosshair():
	var crosshair_texture = preload("res://crosshair.png")
	var crosshair_size = Vector2(25, 25)
	Input.set_custom_mouse_cursor(crosshair_texture, 0, crosshair_size / 2)
