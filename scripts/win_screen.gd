extends CanvasLayer

class_name WinScreen

@onready var current_time_label = $PanelContainer/Panel/VBoxContainer/CurrentTimeLabel
@onready var personal_best_label = $PanelContainer/Panel/VBoxContainer/PersonalBestLabel

@export var hud : HUD

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")


func _on_play_again_button_pressed():
	get_tree().reload_current_scene()

func game_won():
	current_time_label.text = "Your time was: " + hud.timer_count_label.text
	show()
	
