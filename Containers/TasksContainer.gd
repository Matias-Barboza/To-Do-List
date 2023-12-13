extends Panel


var path_task_line : String = "res://Containers/TaskLine.tscn"


onready var add_task_button : Button = $AddTaskButton
onready var tasks_list : VBoxContainer = $ScrollContainer/VBoxContainer
onready var new_task_dialog : WindowDialog = $NewTaskDialog


# Methods
func _ready() -> void:
	
	Events.connect("task_created", self, "add_task")


func add_task(description : String) -> void:
	
	var task_line = load(path_task_line)
	var new_task = task_line.instance()
	
	new_task.get_node_or_null("LineEdit").text = description
	
	tasks_list.add_child(new_task)


func _on_AddTaskButton_pressed() -> void:
	
	new_task_dialog.popup()
