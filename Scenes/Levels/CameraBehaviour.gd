extends Camera2D


export var horizontal_limit : int = 640
export var vertical_limit : int = 640

onready var player = $"../Wizard"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	var x_pos = int(player.position.x)
	var y_pos = int(player.position.y)

	var grid_coordinate = Vector2((abs(x_pos) / horizontal_limit) * sign(x_pos), (abs(y_pos) / vertical_limit)*sign(y_pos))
	self.position = Vector2(grid_coordinate.x * horizontal_limit + horizontal_limit/2*sign(x_pos), grid_coordinate.y * vertical_limit + vertical_limit/2*sign(y_pos))
	
