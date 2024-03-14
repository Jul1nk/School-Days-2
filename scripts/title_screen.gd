extends Node2D


func _ready():
	$AnimationPlayer.play("idle")

# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action_pressed("action"):
		$AnimationPlayer_Transition.play("exit_level")
		await $AnimationPlayer_Transition.animation_finished
		get_tree().change_scene_to_file("res://scenes/levels/game_world.tscn")
		
