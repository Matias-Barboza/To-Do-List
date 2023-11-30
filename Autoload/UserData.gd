extends Node


var user_name : String = "" setget set_user_name, get_user_name


# Methods
func set_user_name(entered_name : String) -> void:
	
	user_name = entered_name


func get_user_name() -> String:
	
	return user_name
