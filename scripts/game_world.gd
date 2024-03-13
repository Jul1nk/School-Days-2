extends Node2D

@onready var player = $CanvasLayer_Player/Player
@onready var animplay_transition = $AnimationPlayer_Transition

@onready var canvas_map = $CanvasLayer_Map
@onready var canvas_layer_mouse = $CanvasLayer_Mouse

@onready var dialog_rt_label = $CanvasLayer_dialog/Control/Dialog_RTLabel
@onready var dialog_timer = $CanvasLayer_dialog/DialogTimer
@onready var canvas_layer_dialog = $CanvasLayer_dialog

var current_level

var in_dialog = false
var can_skip_dialog = false
signal dialog_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	dialog_timer.connect("timeout", _dialog_continue)
	
	_change_level(Global.lvl_path_classroom1_intro, 0)
	player.queue_free()
	
	#player.pause()
	#player._light_intro()
	#player.get_node("player_col").disabled = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Mouse
	canvas_layer_mouse.offset = get_local_mouse_position()
	
	# Dialog
	if can_skip_dialog:
		if Input.is_action_just_pressed("action"):
			player.depause()
			can_skip_dialog = false
			in_dialog = false
			dialog_rt_label.visible_characters = 0
			dialog_rt_label.visible = false
			emit_signal("dialog_finished")
	
	if in_dialog:
		return
	
	# Pause
	if Input.is_action_just_pressed("pause"):
		if !player.is_paused:
			player.pause()
			player.tp_cam_to_pos()
			player.visible = false
			canvas_map.visible = true
			canvas_map.offset = player.position
		else:
			player.depause()
			player.visible = true
			canvas_map.visible = false



func _dialog(text):
	in_dialog = true
	dialog_rt_label.text = text
	dialog_rt_label.visible_characters = 0
	dialog_rt_label.visible = true
	dialog_timer.start()
	#canvas_layer_dialog.offset = player.position
	player.pause()

func _dialog_continue():
	dialog_rt_label.visible_characters += 1
	if dialog_rt_label.visible_ratio != 1:
		dialog_timer.start()
	else:
		can_skip_dialog = true


func _change_level(level: String = Global.lvl_path_classroom1, spawn_point: int = 0):
	var new_level = load(level).instantiate()
	if level != Global.lvl_path_classroom1_intro:
		player.pause()
	
	animplay_transition.play("exit_level")
	await animplay_transition.animation_finished
	
	if current_level:
		current_level.queue_free()
	add_child(new_level)
	current_level = new_level
	
	var spawn = current_level.get_node("SpawnPoints").get_children()[spawn_point]
	if level != Global.lvl_path_classroom1_intro:
		player.position = spawn.position
		player.tp_cam_to_pos()
	
	animplay_transition.play("enter_level")
	await animplay_transition.animation_finished
	if level != Global.lvl_path_classroom1_intro:
		player.depause()
