extends Node2D

@export var nb_layers = 5
@export var layer_distance = 5

@export var colors: Array[Color]

@onready var input = $Input
@onready var output = $Output

@onready var tilemap = $Input/CanvasLayer/TileMap
@onready var canvas_modulate = $Input/CanvasModulate

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var current_distance = 1.0
	
	for i in range(nb_layers):
		var canvas_i = CanvasLayer.new()
		var tilemap_i = tilemap.duplicate()
		var canvas_mod_i = canvas_modulate.duplicate()
		
		canvas_i.follow_viewport_enabled = true
		canvas_i.follow_viewport_scale = current_distance
		print(current_distance)
		current_distance += layer_distance *0.01
		
		if i == nb_layers-1:
			tilemap_i.tile_set = load("res://editor/wall_tileset_shadow.tres")
		tilemap_i.modulate = colors[i%nb_layers]
		
		canvas_i.add_child(tilemap_i)
		canvas_i.add_child(canvas_mod_i)
		output.add_child(canvas_i)
	
	input.queue_free()
