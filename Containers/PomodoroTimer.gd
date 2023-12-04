extends Panel


var tens_minutes : int
var units_minutes : int
var tens_seconds : int
var units_seconds : int
var actual_tens_minutes : int
var actual_units_minutes : int
var actual_tens_seconds : int 
var actual_units_seconds : int
var last_index : int
var study_interval : Array
var rest_interval : Array
var should_rest : bool


onready var pomodoro_timer : Timer = $PomodoroTimer
onready var controller_timer : Timer = $ControllerTimer
onready var tens_minutes_label : Label = $Foreground/BackgroundM/LabelM
onready var units_minutes_label : Label = $Foreground/BackgroundMm/LabelMm
onready var tens_seconds_label : Label = $Foreground/BackgroundS/LabelS
onready var units_seconds_label : Label = $Foreground/BackgroundSs/LabelSs
onready var interval_option_button : OptionButton = $IntervalOptionButton
onready var progress_bar : ProgressBar = $ProgressBar
onready var animation_m : AnimationPlayer = $AnimationPlayerM
onready var animation_mm : AnimationPlayer = $AnimationPlayerMm
onready var animation_s : AnimationPlayer = $AnimationPlayerS
onready var animation_ss : AnimationPlayer = $AnimationPlayerSs
onready var animations_progress_bar : AnimationPlayer = $AnimationPlayerProgressBar


func _ready() -> void:
	
	set_initial_values()
	convert_items_as_not_checkable()


# Methods
func set_initial_values():
	
	should_rest = true
	last_index = -1
	study_interval = [15,1800,2400]
	rest_interval = [10,300,500]


func convert_items_as_not_checkable() -> void:
	
	for i in interval_option_button.get_popup().get_item_count():
		
		interval_option_button.get_popup().set_item_as_radio_checkable(i, false)


func set_pomodoro_time(interval : int) -> void:
	
	pomodoro_timer.wait_time = interval


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
	
	progress_bar.value += 1


func reset_option_button() -> void:
	
	last_index = -1
	
	interval_option_button.select(0)
	interval_option_button.set_deferred("disabled", false)


func set_progress_bar_values(max_val : int, rest_interval = false) -> void:
	
	progress_bar.min_value = 0
	progress_bar.max_value = max_val
	progress_bar.value = 0
	
	if rest_interval:
		
		animations_progress_bar.play("rest_interval_colors")
	else:
		
		animations_progress_bar.play("study_interval_colors")


func _on_PomodoroTimer_timeout() -> void:
	
	$AlarmSFX.play()
	controller_timer.stop()
	
	if should_rest:
		
		
		set_pomodoro_time(rest_interval[last_index])
		
		set_progress_bar_values(rest_interval[last_index], should_rest)
		
		should_rest = false
		
		pomodoro_timer.start()
		controller_timer.start()
	else:
		
		set_progress_bar_values(0, should_rest)
		
		reset_option_button()


func _on_OptionButton_item_selected(index: int) -> void:
	
	if index != last_index:
		
		last_index = index - 1
		
		set_pomodoro_time(study_interval[last_index])


func _on_PlayButton_pressed() -> void:
	
	if last_index != -1:
		
		
		set_progress_bar_values(study_interval[last_index] - 1, false)
		
		pomodoro_timer.start()
		controller_timer.start()
		
		interval_option_button.set_deferred("disabled", true)


func _on_ReplayButton_pressed() -> void:
	
	if not pomodoro_timer.is_stopped():
		
		controller_timer.stop()
		
		set_pomodoro_time(study_interval[last_index])
		
		set_progress_bar_values(study_interval[last_index])
		
		pomodoro_timer.start()
		controller_timer.start()


func _on_StopButton_pressed() -> void:
	
	pomodoro_timer.stop()
	controller_timer.stop()
	
	labels_to_zero()
	
	set_progress_bar_values(study_interval[last_index])
	
	reset_option_button()


func labels_to_zero() -> void:
	
	tens_minutes_label.text = str(0)
	units_minutes_label.text = str(0)
	tens_seconds_label.text = str(0)
	units_seconds_label.text = str(0)
