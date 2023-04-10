extends Area2D


func _on_Scroll_body_entered(body):
	if body is Player:
		(body as Player).collect_object(self)
		queue_free()
