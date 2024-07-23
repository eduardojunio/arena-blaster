extends Node2D

func _ready():
	set_crosshair()

func set_crosshair():
	var crosshair_texture = preload("res://crosshair.png")
	Input.set_custom_mouse_cursor(crosshair_texture)
