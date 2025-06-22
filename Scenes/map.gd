extends Node2D

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		randomSeedMap();
		
func randomSeedMap() -> void:	
	var seedMap = randi()
	print("seedMap is " +  str(seedMap))
	$NoiseGeneratorCliffs.seed = seedMap
	$NoiseGeneratorAsh.seed = seedMap
	$NoiseGeneratorAshDetails.seed = seedMap
	$NoiseGeneratorSoil.seed = seedMap
	
	print("Seedmap set to:" + str($NoiseGeneratorAshDetails.seed))
	
	$NoiseGeneratorCliffs.generate()
	$NoiseGeneratorAsh.generate()
	$NoiseGeneratorAshDetails.generate()
	$NoiseGeneratorSoil.generate()
	
	var rect2i = Rect2i();
	
	$RendererCliffs._draw_area(rect2i)
	$RendererAsh._draw_area(rect2i) 
	$RendererAshDetails._draw_area(rect2i)
	$RendererSoil._draw_area(rect2i)
