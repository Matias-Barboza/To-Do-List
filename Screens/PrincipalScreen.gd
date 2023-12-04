extends Control


var format_greeting = "¡Hola, %s!"
var deploy : bool = false
var panels : Array
var tasks_lists : Array
var days_buttons : Array


onready var greeting_label : Label = $TopBar/Greeting
onready var title_label : Label = $TopBar/Title
onready var tasks_lists_panel : Control = $TasksLists
onready var pomodoro_container_panel : Panel = $Pomodoro/TimerContainer
onready var mo_tasks_list = $TasksLists/MoTasksListContainerPanel
onready var tu_tasks_list = $TasksLists/TuTasksListContainerPanel
onready var we_tasks_list = $TasksLists/WeTasksListContainerPanel
onready var th_tasks_list = $TasksLists/ThTasksListContainerPanel
onready var fr_tasks_list = $TasksLists/FrTasksListContainerPanel
onready var sa_tasks_list = $TasksLists/SaTasksListContainerPanel
onready var su_tasks_list = $TasksLists/SuTasksListContainerPanel
onready var animations : AnimationPlayer = $Animations


# Methods
func _ready() -> void:
	
	greeting_label.text = format_greeting %UserData.get_user_name()
	
	panels = [tasks_lists_panel, pomodoro_container_panel]
	
	tasks_lists = [mo_tasks_list, tu_tasks_list, we_tasks_list,
				   th_tasks_list, fr_tasks_list, sa_tasks_list, su_tasks_list]
	
	connect_day_buttons_to_signal_pressed()


func connect_day_buttons_to_signal_pressed() -> void:
	
	days_buttons = [$DropDownMenu/MenuContainerPanel/VBoxContainer/Monday,
					$DropDownMenu/MenuContainerPanel/VBoxContainer/Tuesday,
					$DropDownMenu/MenuContainerPanel/VBoxContainer/Wednesday,
					$DropDownMenu/MenuContainerPanel/VBoxContainer/Thursday,
					$DropDownMenu/MenuContainerPanel/VBoxContainer/Friday,
					$DropDownMenu/MenuContainerPanel/VBoxContainer/Saturday,
					$DropDownMenu/MenuContainerPanel/VBoxContainer/Sunday]
	
	
	for day_button in days_buttons:
		
		day_button.connect("pressed", self, "_on_Day_Button_pressed", [day_button])


func displacement_drop_down_menu() -> void:
	
	deploy = !deploy
	
	if deploy:
		
		animations.play("deploy")
	else:
		
		animations.play_backwards("deploy")


func change_to_panel(control : Control, controls : Array) -> void:
	
	for c in controls:
		if control == c:
			c.visible = true
		else:
			c.visible = false


func change_days_buttons_visibility(visibility = false) -> void:
	
	for day_button in days_buttons:
		
		day_button.visible = visibility


func change_title(title : String) -> void:
	
	if greeting_label.visible:
		
		greeting_label.visible = false
		title_label.visible = true
	
	title_label.text = title


func _on_DropDownMenu_pressed() -> void:
	
	displacement_drop_down_menu()


func _on_TasksList_pressed() -> void:
	
	change_days_buttons_visibility(true)


func _on_Reminders_pressed() -> void:
	
	displacement_drop_down_menu()


func _on_Timers_pressed() -> void:
	
	displacement_drop_down_menu()
	
	change_to_panel(pomodoro_container_panel, panels)
	
	change_title("Timer Pomodoro")


func _on_Animations_animation_finished(anim_name: String) -> void:
	
	change_days_buttons_visibility()


func _on_Day_Button_pressed(button) -> void:
	
	displacement_drop_down_menu()
	
	change_to_panel(tasks_lists_panel, panels)
	
	var panel : Panel
	var title
	var days_in_spanish : Dictionary = {
		"Monday" : "Lunes",
		"Tuesday" : "Martes",
		"Wednesday" : "Miércoles",
		"Thursday" : "Jueves",
		"Friday" : "Viernes",
		"Saturday" : "Sábado",
		"Sunday" : "Domingo"
	}
	
	match button.get_name():
		"Monday":
			panel = $TasksLists/MoTasksListContainerPanel
		"Tuesday":
			panel = $TasksLists/TuTasksListContainerPanel
		"Wednesday":
			panel = $TasksLists/WeTasksListContainerPanel
		"Thursday":
			panel = $TasksLists/ThTasksListContainerPanel
		"Friday":
			panel = $TasksLists/FrTasksListContainerPanel
		"Saturday":
			panel = $TasksLists/SaTasksListContainerPanel
		"Sunday":
			panel = $TasksLists/SuTasksListContainerPanel
		_:
			panel = null
	
	title = "Lista de tareas del día %s" %days_in_spanish[button.get_name()]
	
	change_to_panel(panel, tasks_lists)
	change_title(title)
