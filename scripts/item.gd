extends ObjectInstance


@export_enum("IMPOSSIBLE","Flashlight", "Key Classroom1", "Key Classroom2", "Key Library",
"Key Office1", "Key Office2", "Statuette", "Key StrangeDoor", "Shovel")
var item_id: int = 1

@export var can_be_taken: bool = true
@export_multiline var dialog = "Picked up"


@onready var area_2d = $Area2D

var player_in = false
var game_world


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global._player_has_item(item_id):
		queue_free()
	
	game_world = get_tree().get_root().get_node("game_world")
	
	area_2d.connect("area_entered", player_entered)
	area_2d.connect("area_exited", player_exited)
	
	_instantiate_object()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player_in:
		if Input.is_action_just_pressed("action"):
			print(dialog)
			player_in = false
			game_world._dialog(dialog)
			await game_world.dialog_finished
			await get_tree().create_timer(0.01).timeout
			player_in = true
			
			if can_be_taken:
				Global._player_add_item(item_id)
				queue_free()



func player_entered(area):
	if area.is_in_group("Player"):
		player_in = true

func player_exited(area):
	if area.is_in_group("Player"):
		player_in = false
