extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.connect("timeout", finish)
	$Timer.start()
	$AnimationPlayer.play("credits")

func finish():
	get_tree().quit()
