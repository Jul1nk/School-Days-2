extends Node2D


@export var nb_layers = 5
@export var layer_distance = 5
@export var colors: Array[Color]

@onready var input = $Input
@onready var canvas_layer = $Input/CanvasLayer
@onready var tilemap_walls = $Input/CanvasLayer/TileMap_Walls
@onready var tilemap_bushes = $Input/CanvasLayer/TileMap_Bushes


#How to make walls with the Wall Maker:
#Place your walls with the white tiles of the Tilemap (Input/CanvasLayer/Tilemap)
#The Wall Maker will automatically create a number of CanvasLayers and their zoom level to create a pseudo-3D effect


func _ready():
	#Output creation
	var output = Node2D.new()
	add_child(output)
	
	#Tilemaps children
	for tilemap in canvas_layer.get_children():
		tilemap.modulate = Color.WHITE
	
	#Variables setup
	var current_distance = 1.0
	var nb_colors = colors.size()
	
		#Creation of the layers
	for i in range(nb_layers):
		#New layer
		var canvas_i = CanvasLayer.new()
		var tilemap_walls_i = tilemap_walls.duplicate()
		var tilemap_bushes_i = tilemap_bushes.duplicate()
		var canvas_mod_i = CanvasModulate.new()
		
		#CanvasLayer setup
		canvas_i.follow_viewport_enabled = true
		canvas_i.follow_viewport_scale = current_distance
		current_distance += layer_distance *0.01
		
		#CanvasModulate setup
		canvas_mod_i.color = Color.BLACK
		
		#Wall color
		@warning_ignore("integer_division") #Annoying but avoids error
		tilemap_walls_i.modulate = colors[(i*nb_colors)/nb_layers]
		
		#Alternate between bush and branch
		#(branch in the first 20%, then alternate between bush1 and bush2)
		@warning_ignore("integer_division") #Warning ignore not working?
		if (i*nb_colors)/nb_layers != 0:
			if i%3 == 1:
				tilemap_bushes_i.tile_set = load("res://editor/bush1_tileset.tres")
			elif i%3 == 2:
				tilemap_bushes_i.tile_set = load("res://editor/bush2_tileset.tres")
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
