extends ObjectInstance

@export_enum("Classroom1", "Classroom2", "Classroom3", "Hallway", "Toilets",
"Yard", "Library", "Office") var next_level: int = 0

@export var spawn_point: int = 0


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
			get_tree().get_root().get_node("game_world")._change_level(Global._int_to_level(next_level), spawn_point)




func player_entered(area):
	if area.is_in_group("Player"):
		player_in = true

func player_exited(area):
	if area.is_in_group("Player"):
		player_in = false
