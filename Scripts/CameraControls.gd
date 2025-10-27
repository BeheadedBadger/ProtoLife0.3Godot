extends Node2D

var speed = 20.0
var map_size = Vector2(640,540)
var viewport_size = Vector2(0,0)
var edge_margin = 20
var zoomedout_viewport_size = Vector2(640,360)

func _process(delta):
	var move_vector = Vector2(0,0)
	var mouse_position = get_viewport().get_mouse_position()
	viewport_size = get_viewport_rect().size
	var panSpeed = 300
	
	#Panning
	if mouse_position.x <= edge_margin:
		move_vector.x -= panSpeed * delta
	if mouse_position.x >= viewport_size.x - edge_margin:
		move_vector.x += panSpeed * delta
	if mouse_position.y >= viewport_size.y - edge_margin:
		move_vector.y += panSpeed * delta
	if mouse_position.y <= edge_margin:
		move_vector.y -= panSpeed * delta
		
	#Move the camera
	position += move_vector

func _input(event):
	var move_vector = Vector2(0,0)
	var zoom_vector = Vector2(0,0)
	
	#Zoom
	#if zoom_value >= minZoom && zoom_value <= maxZoom:
	if Input.is_action_pressed("zoomIn") && $Camera2D.zoom.x < 1:
		zoom_vector =+ Vector2(0.2, 0.2)
	if Input.is_action_pressed("zoomOut") && $Camera2D.zoom.x > 0.2 :
		zoom_vector =- Vector2(0.2, 0.2)
	
	#Movement controls
	if Input.is_action_pressed("left"):
		move_vector.x = -speed
	if Input.is_action_pressed("right"):
		move_vector.x = +speed
	if Input.is_action_pressed("up"):
		move_vector.y = -speed
	if Input.is_action_pressed("down"):
		move_vector.y = +speed
		
	#Move the camera
	position += move_vector
	$Camera2D.zoom += zoom_vector
