class_name Score
extends Label

@export var score = 0

func _ready():
	set_score(score)

func increase_score(value):
	set_score(score + value)

func set_score(value):
	score = value
	text = format_with_commas(value)

func format_with_commas(number):
	var str_number = str(number)
	var result = ""
	while str_number.length() > 3:
		result = "," + str_number.substr(str_number.length() - 3, 3) + result
		str_number = str_number.substr(0, str_number.length() - 3)
	result = str_number + result
	return result
