extends Area2D

@export var is_left_paddle = false


signal Ball_collided_with_me(is_left_paddle)





func _on_body_entered(body: Node2D) -> void:
	if body is Ball:
		Ball_collided_with_me.emit(is_left_paddle)
