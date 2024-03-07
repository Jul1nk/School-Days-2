extends Node2D


@export var nb_frames: int = 6
@export var layer_distance: float = 2.0
@export var shadow_top: bool = false
@export var solid: bool = false
@export var sprite_texture: Texture2D


# Called when the node enters the scene tree for the first time.
func _ready():
		#Creation of a polygon if object is solid or is casting a shadow
	var polygon: PackedVector2Array = []
	#Size of the polygon
	var size = sprite_texture.get_size()
	size.y = int(size.y / nb_frames)
	
	if solid or shadow_top:
		#Polygon setup (4 corners)
		polygon.append(Vector2(0, 0))
		polygon.append(Vector2(size.x, 0))
		polygon.append(Vector2(size.x, size.y))
		polygon.append(Vector2(0, size.y))
	
		#Creation of the layers
	var current_distance = 1.0
	for i in range(nb_frames):
		#New layer
		var canvas_i = CanvasLayer.new()
		var sprite_i = Sprite2D.new()
		var canvas_mod_i = CanvasModulate.new()
		
		#CanvasLayer setup
		canvas_i.follow_viewport_enabled = true
		canvas_i.follow_viewport_scale = current_distance
		current_distance += layer_distance *0.01
		canvas_i.offset = position
		canvas_i.rotation = rotation
		
		#CanvasModulate setup
		canvas_mod_i.color = Color.BLACK
		
		#Sprite setup
		sprite_i.texture = sprite_texture
		sprite_i.vframes = nb_frames
		sprite_i.frame = i
		sprite_i.centered = false
		sprite_i.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		
		#Shadow top setup if object is casting a shadow
		if shadow_top and i == nb_frames-1:
			var light_occluder = LightOccluder2D.new()
			#Occluder setup
			var occluder = OccluderPolygon2D.new()
			occluder.polygon = polygon
			#Adding the LightOccluder2D
			light_occluder.occluder = occluder
			canvas_i.add_child(light_occluder)
		
		#Collision setup if object is solid
		if solid:
			var static_body = StaticBody2D.new()
			#Collision setup
			var collision_polygon = CollisionShape2D.new()
			var rectangle_shape = RectangleShape2D.new()
			rectangle_shape.set_size(size)
			collision_polygon.set_shape(rectangle_shape)
			collision_polygon.position = size * 0.5
			#Adding the StaticBody2D
			static_body.add_child(collision_polygon)
			add_child(static_body)
		
		#Output tree setup
		canvas_i.add_child(sprite_i)
		canvas_i.add_child(canvas_mod_i)
		add_child(canvas_i)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
