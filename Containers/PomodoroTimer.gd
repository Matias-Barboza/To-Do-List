extends Panel


var tens_minutes : int
var units_minutes : int
var tens_seconds : int
var units_seconds : int
var actual_tens_minutes : int
var actual_units_minutes : int
var actual_tens_seconds : int 
var actual_units_seconds : int


onready var pomodoro_timer : Timer = $PomodoroTimer
onready var controller_timer : Timer = $ControllerTimer
onready var tens_minutes_label : Label = $Foreground/BackgroundM/LabelM
onready var units_minutes_label : Label = $Foreground/BackgroundMm/LabelMm
onready var tens_seconds_label : Label = $Foreground/BackgroundS/LabelS
onready var units_seconds_label : Label = $Foreground/BackgroundSs/LabelSs
onready var animation_m : AnimationPlayer = $AnimationPlayerM
onready var animation_mm : AnimationPlayer = $AnimationPlayerMm
onready var animation_s : AnimationPlayer = $AnimationPlayerS
onready var animation_ss : AnimationPlayer = $AnimationPlayerSs


# Methods
func _on_ControllerTimer_timeout() -> void:
	
	var time_left : int = int(pomodoro_timer.time_left)
	
	var new_minutes : int = time_left / 60
	var new_seconds : int = time_left % 60
	
	
	tens_minutes = new_minutes / 10
	units_minutes = new_minutes % 10
	tens_seconds = new_seconds / 10
	units_seconds = new_seconds % 10
	
	actual_tens_minutes = int(tens_minutes_label.text)
	actual_units_minutes = int(units_minutes_label.text)
	actual_tens_seconds = int(tens_seconds_label.text)
	actual_units_seconds = int(units_seconds_label.text)
	
	if(actual_tens_minutes != tens_minutes):
		
		tens_minutes_label.text = str(tens_minutes)
		animation_m.play("m_anim")
	
	if(actual_units_minutes != units_minutes):
		
		units_minutes_label.text = str(units_minutes)
		animation_mm.play("mm_anim")
	
	if(actual_tens_seconds != tens_seconds):
		
		tens_seconds_label.text = str(tens_seconds)
		animation_s.play("s_anim")
	
	units_seconds_label.text = str(units_seconds)
	animation_ss.play("ss_anim")


func _on_PomodoroTimer_timeout() -> void:
	
	controller_timer.stop()


func set_pomodoro_time(time : int) -> void:
	
	pomodoro_timer.wait_time = time
