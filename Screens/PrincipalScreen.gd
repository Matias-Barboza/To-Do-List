extends Control


var format_greeting = "¡Hola, %s!"
var deploy : bool = false
var path_task_line : String = "res://Containers/TaskLine.tscn"
var panels : Array
var left : bool = true


onready var greeting_label : Label = $TopBar/Title
onready var tasks_lists_panel : Panel = $TasksLists/TasksListContainerPanel
onready var pomodoro_container_panel : Panel = $Pomodoro/TimerContainer
onready var morning_panel : Panel = $TasksLists/TasksListContainerPanel/MorningTasks
onready var afternoon_panel : Panel = $TasksLists/TasksListContainerPanel/AfternoonTasks
onready var morning_tasks_list : VBoxContainer = $TasksLists/TasksListContainerPanel/MorningTasks/MorningTasksList/LineTaskContainer
onready var afternoon_tasks_list : VBoxContainer = $TasksLists/TasksListContainerPanel/AfternoonTasks/AfternoonTasksList/LineTaskContainer
onready var animations_toggle_button : AnimationPlayer = $TasksLists/TasksListContainerPanel/ToggleButton/AnimationPlayer
onready var animations : AnimationPlayer = $Animations


# Methods
func _ready() -> void:
	
	greeting_label.text = format_greeting %UserData.get_user_name()
	
	panels = [tasks_lists_panel, pomodoro_container_panel]
	
	#change_to_panel(morning_panel, [morning_panel, afternoon_panel])


func _on_DropDownMenu_pressed() -> void:
	
	displacement_drop_down_menu()


func displacement_drop_down_menu() -> void:
	
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


func change_to_panel(panel : Panel, panels : Array) -> void:
	
	for p in panels:
		if panel == p:
			p.visible = true
		else:
			p.visible = false


func _on_TasksList_pressed() -> void:
	
	displacement_drop_down_menu()
	
	change_to_panel(tasks_lists_panel, panels)


func _on_Reminders_pressed() -> void:
	
	displacement_drop_down_menu()


func _on_Timers_pressed() -> void:
	
	displacement_drop_down_menu()
	
	change_to_panel(pomodoro_container_panel, panels)


func _on_ToggleButton_pressed() -> void:
	
	var panel : Panel
	
	if not left:
		animations_toggle_button.play("toggle_left")
		panel = morning_panel
		animations.play_backwards("change_tasks_list")
	else:
		animations_toggle_button.play("toggle_right")
		panel = afternoon_panel
		animations.play("change_tasks_list")
	
	#change_to_panel(panel, [morning_panel, afternoon_panel])
	
	
	left = !left
