extends Camera2D


export var horizontal_limit : int = 640
export var vertical_limit : int = 640

onready var player = $"../Wizard"

onready var grid_coordinate = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	var grid_x = 0
	var grid_y = 0


	grid_x = floor(player.position.x/horizontal_limit)
	grid_y = floor(player.position.y/vertical_limit)
	
	var new_grid_coordinate = Vector2(grid_x, grid_y)

	if grid_coordinate != new_grid_coordinate:
		change_room(new_grid_coordinate)
	
	
	
func change_room(new_grid_coordinate):
	grid_coordinate = new_grid_coordinate
	var new_position = Vector2(grid_coordinate.x * horizontal_limit + horizontal_limit/2, grid_coordinate.y * vertical_limit + vertical_limit/2)

	player.update_last_entered_position()
	self.position = new_position
