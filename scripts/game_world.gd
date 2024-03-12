extends Node2D

@onready var player = $CanvasLayer_Player/Player
@onready var animplay_transition = $AnimationPlayer_Transition
var current_level


# Called when the node enters the scene tree for the first time.
func _ready():
	_change_level(Global.lvl_path_office, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _change_level(level: String = Global.lvl_path_classroom1, spawn_point: int = 0):
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
