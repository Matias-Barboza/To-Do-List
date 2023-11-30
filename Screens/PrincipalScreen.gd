extends Control


var format_greeting = "¡Hola, %s!"
var deploy : bool = false
var path_task_line : String = "res://Containers/TaskLine.tscn"


onready var greeting_label : Label = $TopBar/Title
onready var morning_tasks_list : VBoxContainer = $TasksList/MorningTasks/MorningTasksList/LineTaskContainer
onready var afternoon_tasks_list : VBoxContainer = $TasksList/AfternoonTasks/AfternoonTasksList/LineTaskContainer
onready var animations : AnimationPlayer = $Animations


func _ready() -> void:
	
	greeting_label.text = format_greeting %UserData.get_user_name()


func _on_DropDownMenu_pressed() -> void:
	
	deploy = !deploy
	
	if deploy:
		
		animations.play("deploy")
	else:
		
		animations.play_backwards("deploy")


func _on_AddMorningTaskButton_pressed() -> void:
	
	add_task(path_task_line, morning_tasks_list)


func _on_AddAfternoonTaskButton_pressed() -> void:
	
	add_task(path_task_line, afternoon_tasks_list)


func add_task(path_task_line : String ,tasks_list : VBoxContainer) -> void:
	
	var task_line = load(path_task_line)
	var new_task = task_line.instance()
	
	tasks_list.add_child(new_task)
