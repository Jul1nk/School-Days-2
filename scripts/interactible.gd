extends ObjectInstance

@export var sound: bool = false
@export var sound_stream: AudioStream

@export_multiline var dialog = "WOW IT'S AN INTERACTIBLE OBJECT!!!"

@export_enum("IMPOSSIBLE","Flashlight", "Key Classroom1", "Key Classroom2", "Key Library",
"Key Office1", "Key Office2", "Statuette", "Key StrangeDoor", "Shovel", "Code")
var special_item: int = 0
@export_multiline var special_dialog = "WOOOOOO SPECIAL ITEM DIALOG YAY BABY"

@export_enum("IMPOSSIBLE","Flashlight", "Key Classroom1", "Key Classroom2", "Key Library",
"Key Office1", "Key Office2", "Statuette", "Key StrangeDoor", "Shovel", "Code")
var special_item2: int = 0
@export_multiline var special_dialog2 = "WOOOOOO SPECIAL ITEM DIALOG2 YAY BABY"

@export var change_look: bool = false
@export var special_nb_frames: int = 6
@export var special_layer_distance: float = 2.0
@export var special_shadow_top: bool = false
@export var special_solid: bool = false
@export var special_sprite_texture: Texture2D

@onready var area_2d = $Area2D

var player_in = false
var game_world
var audio

signal statuette

# Called when the node enters the scene tree for the first time.
func _ready():
	game_world = get_tree().get_root().get_node("game_world")
	
	area_2d.connect("area_entered", player_entered)
	area_2d.connect("area_exited", player_exited)
	
	if sound:
		audio = AudioStreamPlayer.new()
		audio.stream = sound_stream
		add_child(audio)
	
	if ((Global.statuette_put == true and special_item == 7)
	or (Global.pile_dug == true and special_item == 9)):
		dialog = special_dialog
		special_item = special_item2
		special_dialog = special_dialog2
		nb_frames = special_nb_frames
		layer_distance = special_layer_distance
		shadow_top = special_shadow_top
		solid = special_solid
		sprite_texture = special_sprite_texture
	
	_instantiate_object()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player_in:
		if Input.is_action_just_pressed("action"):
			if Global._player_has_item(special_item):
				print(special_dialog)
				player_in = false
				game_world._dialog(special_dialog)
				await game_world.dialog_finished
				await get_tree().create_timer(0.01).timeout
				player_in = true
				
				if special_item == 7:
					emit_signal("statuette")
					audio.play()
					Global.statuette_put = true
					#queue_free()
				if special_item == 9:
					Global.pile_dug = true
				if special_item == 10:
					Global._player_add_item(6)
					#queue_free()
				
				if special_item != 0:
					dialog = special_dialog
					special_item = special_item2
					special_dialog = special_dialog2
				
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
				player_in = false
				game_world._dialog(dialog)
				await game_world.dialog_finished
				await get_tree().create_timer(0.01).timeout
				player_in = true



func player_entered(area):
	if area.is_in_group("Player"):
		player_in = true

func player_exited(area):
	if area.is_in_group("Player"):
		player_in = false
