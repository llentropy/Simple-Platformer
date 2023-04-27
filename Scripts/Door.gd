extends Sprite

export var required_number_of_scrolls = 30
onready var label = $UI/Label

func _ready():
	$UI.visible = false

func _on_InteractableArea_body_entered(body):
	if body is Player:
		var player_scrolls = body.collected_scrolls
		label.text = "%s/%s" %[player_scrolls, required_number_of_scrolls]
		$UI.visible = true
		if player_scrolls >= required_number_of_scrolls:
			open_door()



func _on_InteractableArea_body_exited(body):
	if body is Player:
		print("Exited")
		$UI.visible = false

func open_door():
	yield(get_tree().create_timer(0.8), "timeout")
	queue_free()
