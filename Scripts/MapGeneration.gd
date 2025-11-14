extends Node2D

@export var mapSize = 100
@export var borderSize = 10
@export var dryness = 3
@export var map : FastNoiseLite 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_map()

func generate_map():
	$WaterLayer1.clear()
	$WaterLayer2.clear()
	$Height0.clear()
	$Height1.clear()
	$Height2.clear()
	$Height3.clear()
	$Height4.clear()
	
	var mapTiles : Array[Vector2i] 
	var landTilesLvl1 : Array[Vector2i]
	var landTilesLvl2 : Array[Vector2i]
	var landTilesLvl3 : Array[Vector2i]
	
	#Set tiles within map
	for x in range(mapSize):
		for y in range(mapSize):
			mapTiles.append(Vector2i(x,y))
	
	map.seed = randi_range(100,999)
	
	var moisture = FastNoiseLite.new()
	moisture.seed = randi_range(100,999)
	
	#Get numbers to generate circular shape from center of map
	var center = mapSize / 2
	var radius = center - borderSize
	
	for x in range(mapSize):
		for y in range(mapSize):
			#Get the noisemap and convert to a value between 0 and 1
			var elevationValue = (map.get_noise_2d(x, y) + 1) / 2
			var moistureValue = (moisture.get_noise_2d(x, y) + 1) / 2
			#Use coordinates to calculate if we are within range of the circle
			var dx = center - x
			var dy = center - y
			var distance_squared : float = dx*dx + dy*dy;
			
			#Convert to a value between 0 and 1
			var edgeDetectionValue : float = distance_squared/(radius*radius)
			#Lower towards edge, heighten towards center
			elevationValue += (0.5-edgeDetectionValue)
				
			var landValue = elevationValue - (moistureValue/dryness)
			if landValue > 0.3:
				landTilesLvl1.append(Vector2i(x,y))
			if landValue > 0.4:
				landTilesLvl2.append(Vector2i(x,y))
			if landValue > 0.5:
				landTilesLvl3.append(Vector2i(x,y))
					
	#Use the generated data to set the tiles
	$WaterLayer1.set_cells_terrain_connect(mapTiles, 0, 1, true)
	$WaterLayer2.set_cells_terrain_connect(mapTiles, 0, 2, true)
	
	#Land
	$Height0.set_cells_terrain_connect(landTilesLvl1, 0, 3, true)
	$Height1.set_cells_terrain_connect(landTilesLvl1, 0, 0, true)
	$Height2.set_cells_terrain_connect(landTilesLvl2, 0, 0, true)
	$Height3.set_cells_terrain_connect(landTilesLvl3, 0, 0, true)
	
	#Ash
	$Height2.set_cells_terrain_connect(landTilesLvl1, 0, 4, true)
	$Height3.set_cells_terrain_connect(landTilesLvl2, 0, 4, true)
	$Height4.set_cells_terrain_connect(landTilesLvl3, 0, 4, true)
