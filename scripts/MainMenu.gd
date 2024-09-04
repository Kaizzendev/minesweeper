extends Control

@onready var menu_v_box_container = $PanelContainer/VBoxContainer/MenuVBoxContainer
@onready var game_mode_v_box_container = $PanelContainer/VBoxContainer/GameModeVBoxContainer
@onready var difficulty_v_box_container = $PanelContainer/VBoxContainer/DifficultyVBoxContainer
@onready var options_v_box_container = $PanelContainer/VBoxContainer/OptionsVBoxContainer
@onready var version_num_label = $PanelContainer/Panel/MarginContainer/VersionNumLabel
@onready var vibration_check_box = $PanelContainer/VBoxContainer/OptionsVBoxContainer/VibrationHBoxContainer/VibrationCheckBox
@onready var sound_check_button = $PanelContainer/VBoxContainer/OptionsVBoxContainer/SoundHBoxContainer/SoundCheckButton

const BUTTON_GREEN_TICK = preload("res://assets/button_green_tick.png")
const BUTTON_RED_CROSS = preload("res://assets/button_red_cross.png")

func _ready():
	version_num_label.text = str("Version: " , VersionManager.get_version_number())
	game_mode_v_box_container.hide()
	difficulty_v_box_container.hide()
	options_v_box_container.hide()
	
	if GameOptionsManager.can_vibrate:
		vibration_check_box.texture_normal = BUTTON_GREEN_TICK
	elif !GameOptionsManager.can_vibrate:
		vibration_check_box.texture_normal = BUTTON_RED_CROSS
		
	if GameOptionsManager.can_play_sound:
		sound_check_button.texture_normal = BUTTON_GREEN_TICK
	elif !GameOptionsManager.can_play_sound:
		sound_check_button.texture_normal = BUTTON_RED_CROSS

#Main Menu Actions
func _on_play_button_pressed():
	menu_v_box_container.hide()
	game_mode_v_box_container.show()


func _on_options_button_pressed():
	menu_v_box_container.hide()
	options_v_box_container.show()


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
	
	
#Option Actions
func _on_vibration_check_box_pressed():
	if vibration_check_box.texture_normal == BUTTON_GREEN_TICK:
		vibration_check_box.texture_normal = BUTTON_RED_CROSS
		GameOptionsManager.can_vibrate = false
	elif vibration_check_box.texture_normal == BUTTON_RED_CROSS:
		vibration_check_box.texture_normal = BUTTON_GREEN_TICK
		GameOptionsManager.can_vibrate = true
	


func _on_sound_check_button_pressed():
	if sound_check_button.texture_normal == BUTTON_GREEN_TICK:
		sound_check_button.texture_normal = BUTTON_RED_CROSS
		GameOptionsManager.can_play_sound = false
	elif sound_check_button.texture_normal == BUTTON_RED_CROSS:
		sound_check_button.texture_normal = BUTTON_GREEN_TICK
		GameOptionsManager.can_play_sound = true


func _on_button_pressed():
	menu_v_box_container.show()
	options_v_box_container.hide()
