extends Node2D

@export var crosshair_texture: Texture2D
@export var crosshair_size: Vector2

func _ready():
	set_crosshair()

func set_crosshair():
	Input.set_custom_mouse_cursor(crosshair_texture, 0, crosshair_size / 2)
