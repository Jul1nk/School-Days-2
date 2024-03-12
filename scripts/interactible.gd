extends ObjectInstance

@export_multiline var dialog = "WOW IT'S AN INTERACTIBLE OBJECT!!!"

@export_enum("IMPOSSIBLE","Flashlight", "Key Classroom1", "Key Classroom2", "Key Library",
"Key Office1", "Key Office2", "Statuette", "Key StrangeDoor", "Shovel")
var special_item: int = 0

@export_multiline var special_dialog = "WOOOOOO SPECIAL ITEM DIALOG YAY BABY"

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
			else:
				print(dialog)



func player_entered(area):
	if area.is_in_group("Player"):
		player_in = true

func player_exited(area):
	if area.is_in_group("Player"):
		player_in = false
