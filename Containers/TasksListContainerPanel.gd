extends Panel


var left : bool = true

onready var morning_panel : Panel = $MorningTasksContainer
onready var afternoon_panel : Panel = $AfternoonTasksContainer
onready var animations : AnimationPlayer = $Animations
onready var animations_toggle_button : AnimationPlayer = $ToggleButton/AnimationPlayer


# Methods
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
	
	left = !left
