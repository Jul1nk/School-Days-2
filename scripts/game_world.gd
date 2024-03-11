extends Node2D

var lvl_path_classroom1: String = "res://scenes/levels/classroom_1.tscn"
var lvl_path_classroom2: String = "res://scenes/levels/classroom_2.tscn"
var lvl_path_classroom3: String = "res://scenes/levels/classroom_3.tscn"
var lvl_path_hallway: String = "res://scenes/levels/hallway.tscn"
var lvl_path_toilets: String = "res://scenes/levels/toilets.tscn"
var lvl_path_yard: String = "res://scenes/levels/yard.tscn"
var lvl_path_library: String = "res://scenes/levels/library.tscn"
var lvl_path_office1: String = "res://scenes/levels/office_1.tscn"
var lvl_path_office2: String = "res://scenes/levels/office_2.tscn"


@onready var player = $CanvasLayer_Player/Player
@onready var animplay_transition = $AnimationPlayer_Transition
var current_level


# Called when the node enters the scene tree for the first time.
func _ready():
	_change_level(lvl_path_classroom1, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _change_level(level: String = "res://scenes/levels/classroom_1.tscn", spawn_point: int = 0):
	var new_level = load(level).instantiate()
	player.pause()
	
	animplay_transition.play("exit_level")
	await animplay_transition.animation_finished
	
	if current_level:
		current_level.queue_free()
	add_child(new_level)
	current_level = new_level
	
	var spawn = current_level.get_node("SpawnPoints").get_children()[spawn_point]
	player.position = spawn.position
	player.tp_cam_to_pos()
	
	animplay_transition.play("enter_level")
	await animplay_transition.animation_finished
	player.depause()
