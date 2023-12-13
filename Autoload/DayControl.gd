extends Node

var path_to_save_data_wekly : String = "user://data_weekly.json" setget, get_path_to_save_data_wekly
var last_monday : int

func _ready() -> void:
	
	var current_day = DateTime.now().weekday
	
	if current_day == 1 and current_day != last_monday:
		
		actualize_weekly_dates()


func _process(_delta: float) -> void:
	
	pass
#	DateTime.now()
#	var current_hour : int = OS.get_time().hour
#
#	if current_hour == 0:
#		pass


func get_path_to_save_data_wekly() -> String:
	
	return path_to_save_data_wekly


func get_the_last_month_date() -> void:
	
	pass


func actualize_weekly_dates() -> void: 
	
	var date : DateTime = DateTime.now()
	var week_dates : Array
	var month_and_day : String
	
	
	for i in range(7):
		
		var format_date = date.add_days(i)
		
		month_and_day = format_date.strftime(" %d / %m")
		
		week_dates.insert(i,month_and_day)
	
	print(week_dates)
