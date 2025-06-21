extends Node2D

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		$Camera2D.position.x += 5
	if Input.is_action_pressed("ui_left"):
		$Camera2D.position.x -= 5
	if Input.is_action_pressed("ui_up"):
		$Camera2D.position.y -= 5
	if Input.is_action_pressed("ui_down"):
		$Camera2D.position.y += 5
