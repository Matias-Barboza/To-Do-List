extends WindowDialog


var max_length : int = 103
var remaining_amount : int
var invalid_input : bool = false


onready var text_edit : TextEdit = $TextEdit
onready var max_length_label : Label = $MaxLength


func clean_text_edit() -> void:
	
	text_edit.text = ""
	
	remaining_amount = max_length - text_edit.text.length()
	
	max_length_label.text = "%s/103" % remaining_amount


func _on_TextEdit_text_changed() -> void:
	
	if text_edit.text.length() >= max_length - 1:
		
		text_edit.text = text_edit.text.substr(0, max_length)
		text_edit.cursor_set_column(max_length)
	
	remaining_amount = max_length - text_edit.text.length()
	
	max_length_label.text = "%s/103" % remaining_amount


func _on_hide() -> void:
	
	clean_text_edit()


func _on_CreateButton_pressed() -> void:
	
	Events.emit_signal("task_created", text_edit.text)
	hide()


func _on_CancelButton_pressed() -> void:
	
	hide()
