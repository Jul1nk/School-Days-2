extends ObjectInstance



@export_enum("Classroom1", "Classroom2", "Classroom3", "Hallway", "Toilets",
"Yard", "Library", "Office") var next_level: int = 0
@export var spawn_point: int = 0

@export var locked: bool = true
@export_enum("IMPOSSIBLE","Flashlight", "Key Classroom1", "Key Classroom2", "Key Library",
"Key Office1", "Key Office2", "Statuette", "Key StrangeDoor", "Shovel")
var item_needed: int = 0

@export_multiline var dialog_if_locked = "It's locked"
@export_multiline var dialog_if_unlocked = "It's now unlocked"


@onready var area_2d = $Area2D
var game_world


var player_in = false



# Called when the node enters the scene tree for the first time.
func _ready():
	game_world = get_tree().get_root().get_node("game_world")
	
	area_2d.connect("area_entered", player_entered)
	area_2d.connect("area_exited", player_exited)
	
	_instantiate_object()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player_in:
		if Input.is_action_just_pressed("action"):
			if locked:
				if Global._player_has_item(item_needed):
					print(dialog_if_unlocked)
					locked = false
					game_world._change_level(Global._int_to_level(next_level), spawn_point)
				else:
					print(dialog_if_locked)
			else:
				game_world._change_level(Global._int_to_level(next_level), spawn_point)



func player_entered(area):
	if area.is_in_group("Player"):
		player_in = true

func player_exited(area):
	if area.is_in_group("Player"):
		player_in = false
