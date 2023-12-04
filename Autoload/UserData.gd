extends Node

var path_to_save_data : String = "user://data.json" setget, get_path_to_save_data
var file : File
var user_name : String = "" setget set_user_name, get_user_name


# Methods
func _ready() -> void:

	file = File.new()

	if file.file_exists(path_to_save_data):

		file.open(path_to_save_data, File.READ)

		var text = file.get_as_text()

		var data = parse_json(text)

		user_name = data.name

		get_tree().change_scene("res://Screens/PrincipalScreen.tscn")


func set_user_name(entered_name : String) -> void:
	
	user_name = entered_name


func get_user_name() -> String:
	
	return user_name


func get_path_to_save_data() -> String:
	
	return path_to_save_data
