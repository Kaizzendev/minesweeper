extends Control

@onready var menu_v_box_container = $PanelContainer/VBoxContainer/MenuVBoxContainer
@onready var game_mode_v_box_container = $PanelContainer/VBoxContainer/GameModeVBoxContainer
@onready var difficulty_v_box_container = $PanelContainer/VBoxContainer/DifficultyVBoxContainer
@onready var options_v_box_container = $PanelContainer/VBoxContainer/OptionsVBoxContainer
@onready var version_num_label = $PanelContainer/Panel/VersionNumLabel


func _ready():
	version_num_label.text = str("Version: " , VersionManager.get_version_number())
	game_mode_v_box_container.hide()
	difficulty_v_box_container.hide()
	options_v_box_container.hide()

#Main Menu Actions
func _on_play_button_pressed():
	menu_v_box_container.hide()
	game_mode_v_box_container.show()


func _on_options_button_pressed():
	pass # Replace with function body.


func _on_exit_button_pressed():
	get_tree().quit()

#Game mode Actions
func _on_classic_game_mode_button_pressed():
	difficulty_v_box_container.show()
	game_mode_v_box_container.hide()
	
func _on_back_to_menu_button_pressed():
	menu_v_box_container.show()
	game_mode_v_box_container.hide()

# Difficulty Actions
func _on_easy_button_pressed():
	GameOptionsManager.change_difficulty("Easy")
	get_tree().change_scene_to_file("res://scenes/board.tscn")

func _on_normal_button_pressed():
	GameOptionsManager.change_difficulty("Normal")
	get_tree().change_scene_to_file("res://scenes/board.tscn")


func _on_hard_button_pressed():
	GameOptionsManager.change_difficulty("Hard")
	get_tree().change_scene_to_file("res://scenes/board.tscn")


func _on_back_to_game_mode_button_pressed():
	difficulty_v_box_container.hide()
	game_mode_v_box_container.show()
