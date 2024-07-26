extends Node2D

@export var crosshair_texture: Texture2D
@export var crosshair_size: Vector2
@export var enemy_basic: PackedScene
@export var enemy_shooter: PackedScene

@onready var path_follow_2d = $"Path2D/PathFollow2D"
@onready var spawn_timer = $SpawnTimer
@onready var wave_timer = $WaveTimer
@onready var cooldown_timer = $CooldownTimer
@onready var player = $Player

var spawn_time_decrease = 0.25 # decrease in enemy spawn time in seconds (decreased after a wave)
var min_spawn_time = 1 # in seconds

func _ready():
	set_crosshair()
	spawn_timer.timeout.connect(spawn_enemy)
	wave_timer.timeout.connect(end_wave)
	cooldown_timer.timeout.connect(start_wave)

func set_crosshair():
	Input.set_custom_mouse_cursor(crosshair_texture, 0, crosshair_size / 2)

func start_wave():
	wave_timer.start()
	spawn_timer.start()

func end_wave():
	spawn_timer.stop()
	spawn_timer.wait_time = max(spawn_timer.wait_time - spawn_time_decrease, min_spawn_time)
	cooldown_timer.start()

func spawn_enemy():
	var enemy_instance = get_enemy().instantiate()
	enemy_instance.player = player
	enemy_instance.global_position = get_enemy_position()
	add_child(enemy_instance)

func get_enemy_position():
	path_follow_2d.progress_ratio = randf()
	return path_follow_2d.global_position

func get_enemy():
	var enemies = [enemy_basic, enemy_shooter]
	return enemies[randi() % enemies.size()]
