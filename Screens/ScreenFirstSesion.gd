extends Control


export var principal_screen : PackedScene 


func _on_ContinueButton_pressed() -> void:
	
	if $DataBox/BaseBox/LineEdit.text != "":
		
		var entered_name = $DataBox/BaseBox/LineEdit.text
		UserData.set_user_name(entered_name)
		get_tree().change_scene_to(principal_screen)
