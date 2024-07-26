class_name FlashingComponent extends Node2D

@export var target: Node2D

@onready var flashing_duration = $FlashingDuration
@onready var flashing_interval = $FlashingInterval

func _ready():
	flashing_duration.one_shot = true
	flashing_duration.wait_time = 0.5
	flashing_duration.timeout.connect(stop_flashing)
	flashing_interval.wait_time = 0.075
	flashing_interval.timeout.connect(flash)

func start_flashing():
	flashing_duration.start()
	flashing_interval.start()

func flash():
	target.visible = not target.visible

func stop_flashing():
	flashing_interval.stop()
	target.visible = true
