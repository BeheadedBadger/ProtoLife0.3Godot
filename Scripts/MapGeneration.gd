extends Node2D

@export var mapSize = 100
@export var borderSize = 10
@export var patchiness = 3
@export var dry = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_map()

func generate_map():
	$Height0.clear()
	$Height1.clear()
	$Height2.clear()
	$Height3.clear()
	
	var mapTiles : Array[Vector2i] 
	var landTilesLvl1 : Array[Vector2i]
	var landTilesLvl2 : Array[Vector2i]
	var landTilesLvl3 : Array[Vector2i]
	
	#Set tiles within map
	for x in range(mapSize):
		for y in range(mapSize):
			mapTiles.append(Vector2i(x,y))
	
	#Generate elevation noise
	var elevation = FastNoiseLite.new()
	elevation.seed = randi_range(100,999)
	
	var moisture = FastNoiseLite.new()
	moisture.seed = randi_range(100,999)
	
	#Get numbers to generate circular shape from center of map
	var center = mapSize / 2
	var radius = center - borderSize
	
	for x in range(mapSize):
		for y in range(mapSize):
			#Get the noisemap and convert to a value between 0 and 1
			var elevationValue = (elevation.get_noise_2d(x*patchiness, y*patchiness) + 1) / 2
			var moistureValue = (moisture.get_noise_2d(x*patchiness, y*patchiness) + 1) / 2
			#Use coordinates to calculate if we are within range of the circle
			var dx = center - x
			var dy = center - y
			var distance_squared = dx*dx + dy*dy;
			
			if distance_squared <= radius*radius:
				#This tile is within range, check the noise map for the elevation level
				var landValue = elevationValue - (moistureValue/dry)
				if landValue > 0.3:
					landTilesLvl1.append(Vector2i(x,y))
				if landValue > 0.4:
					landTilesLvl2.append(Vector2i(x,y))
				if landValue > 0.5:
					landTilesLvl3.append(Vector2i(x,y))
					
	#Use the generated data to set the tiles
	$Height0.set_cells_terrain_connect(mapTiles, 0, 1, true)
	$Height1.set_cells_terrain_connect(landTilesLvl1, 0, 0, true)
	$Height2.set_cells_terrain_connect(landTilesLvl2, 0, 0, true)
	$Height3.set_cells_terrain_connect(landTilesLvl3, 0, 0, true)
