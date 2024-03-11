extends Node

var lvl_path_classroom1: String = "res://scenes/levels/classroom_1.tscn"
var lvl_path_classroom2: String = "res://scenes/levels/classroom_2.tscn"
var lvl_path_classroom3: String = "res://scenes/levels/classroom_3.tscn"
var lvl_path_hallway: String = "res://scenes/levels/hallway.tscn"
var lvl_path_toilets: String = "res://scenes/levels/toilets.tscn"
var lvl_path_yard: String = "res://scenes/levels/yard.tscn"
var lvl_path_library: String = "res://scenes/levels/library.tscn"
var lvl_path_office: String = "res://scenes/levels/office.tscn"

func _int_to_level(n):
	match n:
		0: return lvl_path_classroom1
		1: return lvl_path_classroom2
		2: return lvl_path_classroom3
		3: return lvl_path_hallway
		4: return lvl_path_toilets
		5: return lvl_path_yard
		6: return lvl_path_library
		7: return lvl_path_office
