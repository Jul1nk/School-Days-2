extends ObjectInstance

@export_multiline var dialog = "WOW IT'S AN INTERACTIBLE OBJECT!!!"

@export_enum("IMPOSSIBLE","Flashlight", "Key Classroom1", "Key Classroom2", "Key Library",
"Key Office1", "Key Office2", "Statuette", "Key StrangeDoor", "Shovel")
var special_item: int = 0
@export_multiline var special_dialog = "WOOOOOO SPECIAL ITEM DIALOG YAY BABY"

@export var change_look: bool = false
@export var special_nb_frames: int = 6
@export var special_layer_distance: float = 2.0
@export var special_shadow_top: bool = false
@export var special_solid: bool = false
@export var special_sprite_texture: Texture2D

@onready var area_2d = $Area2D

var player_in = false



# Called when the node enters the scene tree for the first time.
func _ready():
	area_2d.connect("area_entered", player_entered)
	area_2d.connect("area_exited", player_exited)
	
	_instantiate_object()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player_in:
		if Input.is_action_just_pressed("action"):
			if Global._player_has_item(special_item):
				print(special_dialog)
				if change_look:
					nb_frames = special_nb_frames
					layer_distance = special_layer_distance
					shadow_top = special_shadow_top
					solid = special_solid
					sprite_texture = special_sprite_texture
					for child in get_children():
						if child is CanvasLayer:
							child.queue_free()
					_instantiate_object()
			else:
				print(dialog)



func player_entered(area):
	if area.is_in_group("Player"):
		player_in = true

func player_exited(area):
	if area.is_in_group("Player"):
		player_in = false
