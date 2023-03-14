extends Node


export var spell_check_time = 0.5
onready var timer = $DirectionListCleanTimer
onready var player = $".."
var directions_sequence = []

onready var spells_list = {
	["up", "down", "up", "down"] : "flip_gravity"
}

var directions = ["up", "down", "left", "right"]
var event_string = "ui_%s"
func _input(event):
	for direction in directions:
		if event.is_action_pressed(event_string % direction):
			process_input_direction(direction)

func process_input_direction(direction):
	directions_sequence.append(direction)
	var got = spells_list.get(directions_sequence)
	if got != null:
		directions_sequence.clear()
		match got:
			"flip_gravity":
				player.flip_gravity()
	timer.start(spell_check_time)
	



func _on_DirectionListCleanTimer_timeout():
	print(directions_sequence) 
	directions_sequence.clear()
