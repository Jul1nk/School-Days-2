extends Node2D

@export var nb_frames: int = 6
@export var layer_distance: float = 2.0

@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var current_distance = 1.0
	
		#Creation of the layers
	for i in range(nb_frames):
		#New layer
		var canvas_i = CanvasLayer.new()
		var sprite_i = sprite.duplicate()
		var canvas_mod_i = CanvasModulate.new()
		
		#CanvasLayer setup
		canvas_i.follow_viewport_enabled = true
		canvas_i.follow_viewport_scale = current_distance
		current_distance += layer_distance *0.01
		
		canvas_i.offset = position
		
		#CanvasModulate setup
		canvas_mod_i.color = Color.BLACK
		
		#Sprite setup
		sprite_i.vframes = nb_frames
		sprite_i.frame = i
		
		#Output tree setup
		canvas_i.add_child(sprite_i)
		canvas_i.add_child(canvas_mod_i)
		add_child(canvas_i)
		
		#printt(i, sprite_i.hframes, canvas_i.name)
	
	#Delete Input
	sprite.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
