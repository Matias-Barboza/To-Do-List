extends Panel


var path_task_line : String = "res://Containers/TaskLine.tscn"


onready var add_task_button : Button = $AddTaskButton
onready var tasks_list : VBoxContainer = $ScrollContainer/VBoxContainer


# Methods
func add_task() -> void:
	
	var task_line = load(path_task_line)
	var new_task = task_line.instance()
	
	tasks_list.add_child(new_task)

func _on_AddTaskButton_pressed() -> void:
	
	add_task()
