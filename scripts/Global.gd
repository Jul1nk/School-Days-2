extends Node

var lvl_path_classroom1_intro_glitched: String = "res://scenes/levels/classroom_1_intro_glitched.tscn"
var lvl_path_classroom1_intro: String = "res://scenes/levels/classroom_1_intro.tscn"
var lvl_path_classroom1: String = "res://scenes/levels/classroom_1.tscn"
var lvl_path_classroom2: String = "res://scenes/levels/classroom_2.tscn"
var lvl_path_classroom3: String = "res://scenes/levels/classroom_3.tscn"
var lvl_path_hallway: String = "res://scenes/levels/hallway.tscn"
var lvl_path_toilets: String = "res://scenes/levels/toilets.tscn"
var lvl_path_yard: String = "res://scenes/levels/yard.tscn"
var lvl_path_library: String = "res://scenes/levels/library.tscn"
var lvl_path_office: String = "res://scenes/levels/office.tscn"
var lvl_path_end: String = "res://scenes/levels/end.tscn"

var item_flashlight: bool = true
var item_key_classroom1: bool = false
var item_key_classroom2: bool = false
var item_key_library: bool = false
var item_key_office1: bool = false


 

  
var item_key_office2: bool = false
var item_statuette: bool = false
var item_key_strangedoor: bool = false
var item_shovel: bool = false
var item_code: bool = false


var statuette_put: bool = false
var pile_dug: bool = false

var door_classroom1_open: bool = false
var door_classroom2_open: bool = false
var door_office1_open: bool = false
var door_office2_open: bool = false
var door_library_open: bool = false

func _int_to_level(n=0):
	match n:
		0: return lvl_path_classroom1
		1: return lvl_path_classroom2
		2: return lvl_path_classroom3
		3: return lvl_path_hallway
		4: return lvl_path_toilets
		5: return lvl_path_yard
		6: return lvl_path_library
		7: return lvl_path_office
		8: return lvl_path_end


func _player_has_item(n=0):
	match n:
		0: return false
		1: return item_flashlight
		2: return item_key_classroom1
		3: return item_key_classroom2
		4: return item_key_library
		5: return item_key_office1
		6: return item_key_office2
		7: return item_statuette
		8: return item_key_strangedoor
		9: return item_shovel
		10: return item_code


func _player_add_item(n=1):
	match n:
		1: item_flashlight = true
		2: item_key_classroom1 = true
		3: item_key_classroom2 = true
		4: item_key_library = true
		5: item_key_office1 = true
		6: item_key_office2 = true
		7: item_statuette = true
		8: item_key_strangedoor = true
		9: item_shovel = true
		10: item_code = true


func _open_door(n):
	match(n):
		0: return
		1: door_classroom1_open = true
		2: door_classroom2_open = true
		3: door_office1_open = true
		4: door_office2_open = true
		5: door_library_open = true

func _is_door_open(n):
	match(n):
		1: return door_classroom1_open
		2: return door_classroom2_open
		3: return door_office1_open
		4: return door_office2_open
		5: return door_library_open
	return false

