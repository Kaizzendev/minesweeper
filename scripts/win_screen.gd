extends CanvasLayer

class_name WinScreen

@onready var current_time_label = $PanelContainer/Panel/VBoxContainer/CurrentTimeLabel
@onready var personal_best_label = $PanelContainer/Panel/VBoxContainer/PersonalBestLabel
@onready var new_record_label = $PanelContainer/Panel/VBoxContainer/NewRecordLabel

@export var hud : HUD

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")


func _on_play_again_button_pressed():
	get_tree().reload_current_scene()

func game_won():
	if  DataManager.load_data() == null:
		DataManager.data = {time_record = hud.total_time_seconds} 
		DataManager.save_data(DataManager.data)
	DataManager.data = DataManager.load_data()
	var current_record = DataManager.data.get("time_record")
	if hud.total_time_seconds <= current_record:
		new_record_label.show()
		new_record_label.text = "New Record!! " + hud.timer_count_label.text
		personal_best_label.text = "Personal best: " + hud.timer_count_label.text
		DataManager.data = {time_record = hud.total_time_seconds} 
		DataManager.save_data(DataManager.data)
	else:
		fill_personal_record_label(current_record)
	current_time_label.text = "Your time was: " + hud.timer_count_label.text
	show()
	
func fill_personal_record_label(total_time_seconds):
	var minutes = int(total_time_seconds / 60)
	var seconds = total_time_seconds - minutes * 60
	personal_best_label.text = "Personal best: " + "%02d:%02d" % [minutes,seconds]
