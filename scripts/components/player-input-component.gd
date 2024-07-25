class_name PlayerInputComponent extends InputComponent

func get_direction():
	return Input.get_vector("left", "right", "up", "down")

func get_look_target():
	return get_global_mouse_position()
