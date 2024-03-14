extends Node2D

@onready var player = $CanvasLayer_Player/Player
@onready var animplay_transition = $AnimationPlayer_Transition

@onready var canvas_map = $CanvasLayer_Map
@onready var canvas_layer_mouse = $CanvasLayer_Mouse

@onready var dialog_rt_label = $CanvasLayer_dialog/Control/Dialog_RTLabel
@onready var dialog_timer = $CanvasLayer_dialog/DialogTimer
@onready var canvas_layer_dialog = $CanvasLayer_dialog

var current_level
var current_level_path = Global.lvl_path_classroom1_intro

var in_dialog = false
var can_skip_dialog = false
signal dialog_finished


var dialog_intro = [
	"Mr.Hibou: Hello class! I hope you all had a great weekend.",
	"Mr.Hibou: I see some of you are absent today so I'll call you by your name.",
	"Mr.Hibou: Lilly?",
	"I'm here!",
	"Mr.Hibou: Alex?",
	"Present!",
	"Mr.Hibou: Tweek?",
	"Tweek: Present!",
	"(Tweek: I'm so tired...)",
	"Mr.Hibou: Mary?",
	"...",
	"Mr.Hibou: Mary isn't here...",
	"(Tweek: I want to go back to bed...)",
	"GLITCH",
	"Mr.Hibou: You won't make it out alive, Tweek.",
	"DEGLITCH",
	"(Tweek: What was that?!)",
	"Mr.Hibou: Tweek, are you okay?",
	"Tweek: ...",
	"GLITCH",
	"Mr.Hibou: I SAID: ARE YOU OKAY TWEEK?",
	"Tweek: NO! NO NO!",
	"GLITCH FINISH"
	]


# Called when the node enters the scene tree for the first time.
func _ready():
	dialog_timer.connect("timeout", _dialog_continue)
	$RandomNoiseTimer.connect("timeout", _play_sound)
	
	_change_level(Global.lvl_path_classroom1_intro, 0)
	
	player._hide()
	
	await animplay_transition.animation_finished
	await animplay_transition.animation_finished
	
	if current_level_path == Global.lvl_path_classroom1_intro or current_level_path == Global.lvl_path_classroom1_intro_glitched:
		for i in range(dialog_intro.size()):
			_dialog(dialog_intro[i])
			await dialog_finished



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Mouse
	canvas_layer_mouse.offset = get_local_mouse_position()
	
	# Dialog
	if can_skip_dialog:
		if Input.is_action_just_pressed("action"):
			if current_level_path != Global.lvl_path_classroom1_intro and current_level_path != Global.lvl_path_classroom1_intro_glitched:
				player.depause()
			can_skip_dialog = false
			in_dialog = false
			dialog_rt_label.visible_characters = 0
			canvas_layer_dialog.visible = false
			emit_signal("dialog_finished")
	
	if in_dialog:
		return
	
	# Pause
	if Input.is_action_just_pressed("pause"):
		$MapSFX.play()
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


func _play_sound():
	if current_level_path != Global.lvl_path_hallway:
		return
	var sound = randi()%2
	if sound == 0:
		$SFX.stream = load("res://assets/sfx/sounds/random1.wav")
	else:
		$SFX.stream = load("res://assets/sfx/sounds/random2.wav")
	$SFX.play()



func _dialog(text):
	
	if text == "GLITCH":
		$GlitchSFX.play()
		$Music.stream = load("res://assets/sfx/music/Solitude.wav")
		$Music.play()
		$Black.modulate = Color.BLACK
		_change_level(Global.lvl_path_classroom1_intro_glitched, 0, true)
		await animplay_transition.animation_finished
		await animplay_transition.animation_finished
		emit_signal("dialog_finished")
		return
	elif text == "GLITCH FINISH":
		$GlitchSFX.play()
		$Black.modulate = Color.BLACK
		_change_level(Global.lvl_path_classroom1, 1, true)
		await animplay_transition.animation_finished
		player._hide()
		await animplay_transition.animation_finished
		emit_signal("dialog_finished")
		return
	elif text == "DEGLITCH":
		$GlitchSFX.play()
		$Music.stream = load("res://assets/sfx/music/School Days 2 theme.wav")
		$Music.play()
		$Black.modulate = Color(20/255.0,35/255.0,58/255.0)
		_change_level(Global.lvl_path_classroom1_intro, 0, true)
		await animplay_transition.animation_finished
		await animplay_transition.animation_finished
		emit_signal("dialog_finished")
		return
	
	in_dialog = true
	dialog_rt_label.text = text
	dialog_rt_label.visible_characters = 0
	canvas_layer_dialog.visible = true
	dialog_timer.start()
	if current_level_path != Global.lvl_path_classroom1_intro and current_level_path != Global.lvl_path_classroom1_intro_glitched:
		player.pause()

func _dialog_continue():
	dialog_rt_label.visible_characters += 1
	if dialog_rt_label.visible_ratio != 1:
		dialog_timer.start()
	else:
		can_skip_dialog = true


func _change_level(level: String = Global.lvl_path_classroom1, spawn_point: int = 0, glitched: bool = false):
	var new_level = load(level).instantiate()
	if current_level_path != Global.lvl_path_classroom1_intro and current_level_path != Global.lvl_path_classroom1_intro_glitched:
		player.pause()
	
	if glitched:
		animplay_transition.play("glitch_enter")
	else:
		animplay_transition.play("exit_level")
		if level != Global.lvl_path_classroom1_intro and level != Global.lvl_path_classroom1_intro_glitched:
			$SFX.stream = load("res://assets/sfx/sounds/opendoor.wav")
			$SFX.play()
	await animplay_transition.animation_finished
	
	if current_level:
		current_level.queue_free()
	add_child(new_level)
	current_level = new_level
	current_level_path = level
	
	var spawn = current_level.get_node("SpawnPoints").get_children()[spawn_point]
	if level != Global.lvl_path_classroom1_intro and level != Global.lvl_path_classroom1_intro_glitched:
		player.position = spawn.position
		player.tp_cam_to_pos()
	
	if (current_level_path == Global.lvl_path_office and (spawn_point==1 or spawn_point==3)
	or current_level_path == Global.lvl_path_end):
		$Aberration.play()
	if current_level_path == Global.lvl_path_hallway:
		var time = randf_range(30.0,60.0)
		$RandomNoiseTimer.wait_time = time
		$RandomNoiseTimer.start()
	
	if glitched:
		animplay_transition.play("glitch_exit")
	else:
		animplay_transition.play("enter_level")
		if level != Global.lvl_path_classroom1_intro and level != Global.lvl_path_classroom1_intro_glitched:
			$SFX.stream = load("res://assets/sfx/sounds/closedoor.wav")
			$SFX.play()
			
	await animplay_transition.animation_finished
	if level != Global.lvl_path_classroom1_intro and level != Global.lvl_path_classroom1_intro_glitched:
		player.depause()
	
	if current_level_path == Global.lvl_path_end:
		_dialog("\nMr.Hibou: Hi Tweek...")
		await dialog_finished
		get_tree().change_scene_to_file("res://scenes/credits.tscn")
