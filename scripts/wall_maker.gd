extends Node2D


@export var nb_layers = 5
@export var layer_distance = 5
@export var colors: Array[Color]

@onready var input = $Input
@onready var tilemap_walls = $Input/CanvasLayer/TileMap_Walls
@onready var tilemap_bushes = $Input/CanvasLayer/TileMap_Bushes
@onready var canvas_modulate = $Input/CanvasModulate

@onready var output = $Output

#How to make walls with the Wall Maker:
#Place your walls with the white tiles of the Tilemap (Input/CanvasLayer/Tilemap)
#The Wall Maker will automatically create a number of CanvasLayers and their zoom level to create a pseudo-3D effect


func _ready():
	var current_distance = 1.0
	var nb_colors = colors.size()
	
	tilemap_walls.modulate = Color.WHITE
	tilemap_walls.modulate = Color.WHITE
	
		#Creation of the layers
	for i in range(nb_layers):
		#New layer
		var canvas_i = CanvasLayer.new()
		var tilemap_walls_i = tilemap_walls.duplicate()
		var tilemap_bushes_i = tilemap_bushes.duplicate()
		var canvas_mod_i = canvas_modulate.duplicate()
		
		#CanvasLayer setup
		canvas_i.follow_viewport_enabled = true
		canvas_i.follow_viewport_scale = current_distance
		current_distance += layer_distance *0.01
		
		#Wall color
		@warning_ignore("integer_division") #Annoying but avoids error
		tilemap_walls_i.modulate = colors[(i*nb_colors)/nb_layers]
		
		#Alternate between bush and branch
		if i != 0:
			tilemap_bushes_i.tile_set = load("res://editor/bush_tileset.tres")
		else:
			tilemap_bushes_i.tile_set = load("res://editor/branch_tileset.tres")
		
		#If Tilemap is last, make it emit shadows
		if i == nb_layers-1:
			tilemap_walls_i.tile_set = load("res://editor/wall_tileset_shadow.tres")
			tilemap_bushes_i.tile_set = load("res://editor/wall_tileset_shadow.tres")
		
		#Output tree setup
		canvas_i.add_child(tilemap_walls_i)
		canvas_i.add_child(tilemap_bushes_i)
		canvas_i.add_child(canvas_mod_i)
		output.add_child(canvas_i)
	
	#Delete Input
	input.queue_free()
