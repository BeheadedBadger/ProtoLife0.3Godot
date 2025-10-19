extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Put camera in the center of the map on startup
	$PlayerControls.position = Vector2(($MapGeneration.mapSize * 73) / 2, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if($PlayerControls/Button.button_pressed):
		$MapGeneration.generate_map()
