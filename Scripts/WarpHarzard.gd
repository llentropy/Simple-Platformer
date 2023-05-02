extends Area2D



func _on_WarpHazard_body_entered(body):
	if body is Player:
		body.warp_to_room_start()


