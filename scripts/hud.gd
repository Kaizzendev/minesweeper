extends CanvasLayer

class_name HUD

const BUTTON_FLAG = preload("res://assets/button_flag.png")
const BUTTON_MINE = preload("res://assets/button_mine.png")
@onready var mine_swap_button = $VBoxContainer/PanelContainer/HBoxContainer/HBoxContainer/MineSwapButton

@onready var notch_panel = $VBoxContainer/NotchPanel

@onready var mine_count_label = $VBoxContainer/PanelContainer/HBoxContainer/MarginContainer/MinePanel/MineCountLabel
@onready var timer_count_label = $VBoxContainer/PanelContainer/HBoxContainer/MarginContainer2/TimerPanel/TimerCountLabel
@onready var game_state_button = $VBoxContainer/PanelContainer/HBoxContainer/HBoxContainer/GameStateButton

@onready var panel_container = $VBoxContainer/PanelContainer

const BUTTON_CLEARED = preload("res://assets/button_cleared.png")
const BUTTON_DEAD = preload("res://assets/button_dead.png")

@onready var timer = $VBoxContainer/PanelContainer/HBoxContainer/MarginContainer2/TimerPanel/Timer
var total_time_seconds : int = 0

@onready var in_game_options = $"../InGameOptions"

func _ready():
	var safe_area = DisplayServer.get_display_safe_area().size
	var screen_size = DisplayServer.window_get_size()
	notch_panel.custom_minimum_size = Vector2(safe_area.x, screen_size.y - safe_area.y)
	notch_panel.size.x = safe_area.x
	
	timer.start()

func set_mine_counter(mines_number: int):
	var mines_number_to_string = str(mines_number)
	if mines_number_to_string.length() > 3:
		mines_number_to_string = mines_number_to_string.lpad(3, "0")
	
	mine_count_label.text = mines_number_to_string

func _on_game_state_button_pressed():
	GameOptionsManager.is_mine_swap = false
	get_tree().reload_current_scene()
	
func game_lost():
	timer.stop()
	game_state_button.texture_normal = BUTTON_DEAD
	
func game_won():
	timer.stop()
	game_state_button.texture_normal = BUTTON_CLEARED

func _on_mine_swap_button_pressed():
	GameOptionsManager.is_mine_swap = !GameOptionsManager.is_mine_swap
	if mine_swap_button.texture_normal == BUTTON_MINE:
		mine_swap_button.texture_normal = BUTTON_FLAG
	elif mine_swap_button.texture_normal == BUTTON_FLAG:
		mine_swap_button.texture_normal = BUTTON_MINE


func _on_timer_timeout():
	total_time_seconds +=1
	var minutes = int(total_time_seconds / 60)
	var seconds = total_time_seconds - minutes * 60
	timer_count_label.text = "%02d:%02d" % [minutes,seconds]
	

func _on_in_game_options_button_pressed():
	if in_game_options.visible:
		timer.start()
		in_game_options.hide()
	else:
		timer.stop()
		in_game_options.show()
