extends TileMapLayer

func _process(delta: float) -> void:
	if(Input.is_action_pressed("mb_left")):
		SetTileAtMouse(0,0,Vector2(-1,-1))
		var tile : Vector2 = local_to_map(get_global_mouse_position())
		print("Left. Position is:" + str(tile))

func SetTileAtMouse(Layer: int = 0, ID : int = 0, Type: Vector2 = Vector2(0,0)):
	$".".set_cells_terrain_connect([$".".local_to_map(get_global_mouse_position())], 0, -1, true)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
