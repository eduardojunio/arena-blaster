class_name EnemyInputComponent extends InputComponent

@export var enemy: Enemy

func get_direction():
	return (get_look_target() - enemy.global_position).normalized()

func get_look_target():
	return enemy.player.get_sprite_position()

func is_shooting():
	return true
