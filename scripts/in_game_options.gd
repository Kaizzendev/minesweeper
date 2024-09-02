extends CanvasLayer

@onready var hud = $"../HUD"
@onready var vibration_check_box = $PanelContainer/VBoxContainer/VibrationHBoxContainer/VibrationCheckBox
@onready var sound_check_button = $PanelContainer/VBoxContainer/SoundHBoxContainer/SoundCheckButton
const BUTTON_GREEN_TICK = preload("res://assets/button_green_tick.png")
const BUTTON_RED_CROSS = preload("res://assets/button_red_cross.png")
func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_resume_button_pressed():
	hud.timer.start()
	hide()


func _on_vibration_check_box_pressed():
	if vibration_check_box.texture_normal == BUTTON_GREEN_TICK:
		vibration_check_box.texture_normal = BUTTON_RED_CROSS
	elif vibration_check_box.texture_normal == BUTTON_RED_CROSS:
		vibration_check_box.texture_normal = BUTTON_GREEN_TICK
	GameOptionsManager.swap_vibration()


func _on_sound_check_button_pressed():
	if sound_check_button.texture_normal == BUTTON_GREEN_TICK:
		sound_check_button.texture_normal = BUTTON_RED_CROSS
	elif sound_check_button.texture_normal == BUTTON_RED_CROSS:
		sound_check_button.texture_normal = BUTTON_GREEN_TICK
	GameOptionsManager.swap_sound()
