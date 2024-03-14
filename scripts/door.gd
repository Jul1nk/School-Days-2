extends ObjectInstance



@export_enum("Classroom1", "Classroom2", "Classroom3", "Hallway", "Toilets",
"Yard", "Library", "Office", "End") var next_level: int = 0
@export var spawn_point: int = 0

@export var locked: bool = true
@export_enum("IMPOSSIBLE","Flashlight", "Key Classroom1", "Key Classroom2", "Key Library",
"Key Office1", "Key Office2", "Statuette", "Key StrangeDoor", "Shovel", "Code")
var item_needed: int = 0

@export_enum("NOTHING", "Classroom1", "Classroom2", "Office1", "Office2", "Library")
var room_opening: int = 0

@export_multiline var dialog_if_locked = "It's locked..."
@export_multiline var dialog_if_unlocked = "It's now unlocked"


@onready var area_2d = $Area2D
var game_world


var player_in = false



# Called when the node enters the scene tree for the first time.
func _ready():
	game_world = get_tree().get_root().get_node("game_world")
	
	area_2d.connect("area_entered", player_entered)
	area_2d.connect("area_exited", player_exited)
	
	if Global._is_door_open(room_opening):
		locked = false
	
	_instantiate_object()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player_in:
		if Input.is_action_just_pressed("action"):
			if locked:
				if Global._player_has_item(item_needed):
					Global._open_door(room_opening)
					print(dialog_if_unlocked)
					game_world._dialog(dialog_if_unlocked)
					player_in = false
					await game_world.dialog_finished
					locked = false
					game_world._change_level(Global._int_to_level(next_level), spawn_point)
				else:
					print(dialog_if_locked)
					player_in = false
					game_world._dialog(dialog_if_locked)
					await game_world.dialog_finished
					await get_tree().create_timer(0.01).timeout
					player_in = true
			else:
				game_world._change_level(Global._int_to_level(next_level), spawn_point)



func player_entered(area):
	if area.is_in_group("Player"):
		player_in = true

func player_exited(area):
	if area.is_in_group("Player"):
		player_in = false
