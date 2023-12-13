extends Panel


var tens_minutes : int = 0
var units_minutes : int = 0
var tens_seconds : int = 0
var units_seconds : int = 0
var actual_tens_minutes : int = 0
var actual_units_minutes : int = 0
var actual_tens_seconds : int = 0
var actual_units_seconds : int = 0
var last_index : int
var study_intervals : Array 
var rest_intervals : Array
var should_rest : bool
var time_left : int


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
	study_intervals = [1500,1800,2400]
	rest_intervals = [300,300,500]


func convert_items_as_not_checkable() -> void:
	
	for i in interval_option_button.get_popup().get_item_count():
		
		interval_option_button.get_popup().set_item_as_radio_checkable(i, false)


func _on_ControllerTimer_timeout() -> void:
	
	time_left -= 1
	
	tens_minutes =  (time_left / 60) / 10
	units_minutes = (time_left / 60) % 10
	tens_seconds = (time_left % 60) / 10
	units_seconds = (time_left % 60) % 10
	
	actual_tens_minutes = int(tens_minutes_label.text)
	actual_units_minutes = int(units_minutes_label.text)
	actual_tens_seconds = int(tens_seconds_label.text)
	actual_units_seconds = int(units_seconds_label.text)
	
	if(actual_tens_minutes != tens_minutes):
		
		animation_m.play("m_anim")
		tens_minutes_label.text = str(tens_minutes)
	
	if(actual_units_minutes != units_minutes):
		
		animation_mm.play("mm_anim")
		units_minutes_label.text = str(units_minutes)
	
	if(actual_tens_seconds != tens_seconds):
		
		animation_s.play("s_anim")
		tens_seconds_label.text = str(tens_seconds)
	
	if(actual_units_seconds != units_seconds):
		
		animation_ss.play("ss_anim")
		units_seconds_label.text = str(units_seconds)
	
	progress_bar.value += 1
	
	
	if time_left == 0:
		
		controller_timer.stop()
		$AlarmSFX.play()
		
		if should_rest:
			
			set_time(rest_intervals[last_index])
			
			set_progress_bar_values(rest_intervals[last_index], should_rest)
			
			should_rest = false
			
			controller_timer.start()
		else:
			
			set_progress_bar_values(100, should_rest)
			
			reset_option_button()


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


func set_time(time : int) -> void:
	
	time_left = time


func _on_OptionButton_item_selected(index: int) -> void:
	
	if index != last_index:
		
		last_index = index - 1
		
		set_time(study_intervals[last_index])


func _on_PlayButton_pressed() -> void:
	
	if last_index != -1:
		
		set_progress_bar_values(study_intervals[last_index], false)
		
		controller_timer.start()
		
		interval_option_button.set_deferred("disabled", true)


func _on_ReplayButton_pressed() -> void:
	
	if not controller_timer.is_stopped():
		
		controller_timer.stop()
		
		set_time(study_intervals[last_index])
		
		set_progress_bar_values(study_intervals[last_index])
		
		should_rest = true
		
		controller_timer.start()


func _on_StopButton_pressed() -> void:
	
	if controller_timer.is_stopped():
		return
	
	controller_timer.stop()
	
	labels_to_zero()
	
	set_progress_bar_values(study_intervals[last_index])
	
	reset_option_button()


func labels_to_zero() -> void:
	
	tens_minutes_label.text = str(0)
	units_minutes_label.text = str(0)
	tens_seconds_label.text = str(0)
	units_seconds_label.text = str(0)
