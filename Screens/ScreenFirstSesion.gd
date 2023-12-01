extends Control


export var principal_screen : PackedScene 


# Methods
func _on_ContinueButton_pressed() -> void:
	
	if $DataBox/BaseBox/LineEdit.text != "":
		
		var entered_name : String = $DataBox/BaseBox/LineEdit.text
		var data_to_save : Dictionary = {"name" : entered_name}
		
		save_in_JSON(UserData.get_path_to_save_data(), to_json(data_to_save))
		
		UserData.set_user_name(entered_name)
		
		get_tree().change_scene("res://Screens/PrincipalScreen.tscn")


func save_in_JSON(path : String, json_string : String) -> void:
	
	var file = File.new()
	
	if not file.file_exists(path):
		
		file.open(path, File.WRITE)
		file.store_line(json_string)
		file.close()
