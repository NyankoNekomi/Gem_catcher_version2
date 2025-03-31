extends Area2D


@export var SPEED = 400


func _process(delta: float) -> void:
	if Input.is_action_pressed("move_left") == true:
		position.x -= SPEED * delta #position.x = postion.x - (speed x delta)
	if Input.is_action_pressed("move_right") == true:
		position.x += SPEED * delta 
		
	position.x = clampf(position.x, get_viewport_rect().position.x, get_viewport_rect().end.x)
