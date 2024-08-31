extends CanvasLayer

class_name HUD

@onready var notch_panel = $VBoxContainer/NotchPanel

@onready var mine_count_label = $VBoxContainer/PanelContainer/HBoxContainer/MarginContainer/MinePanel/MineCountLabel
@onready var timer_count_label = $VBoxContainer/PanelContainer/HBoxContainer/MarginContainer/TimerPanel/TimerCountLabel
@onready var game_state_button = $VBoxContainer/PanelContainer/HBoxContainer/HBoxContainer/GameStateButton

@onready var panel_container = $VBoxContainer/PanelContainer

const BUTTON_CLEARED = preload("res://assets/button_cleared.png")
const BUTTON_DEAD = preload("res://assets/button_dead.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	var safe_area = DisplayServer.get_display_safe_area().size
	var screen_size = DisplayServer.window_get_size()
	notch_panel.custom_minimum_size = Vector2(safe_area.x, screen_size.y - safe_area.y)
	notch_panel.size.x = safe_area.x
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_mine_counter(mines_number: int):
	var mines_number_to_string = str(mines_number)
	if mines_number_to_string.length() > 3:
		mines_number_to_string = mines_number_to_string.lpad(3, "0")
	
	mine_count_label.text = mines_number_to_string


func _on_game_state_button_pressed():
	get_tree().reload_current_scene()
	
func game_lost():
	game_state_button.texture_normal = BUTTON_DEAD
	
func game_won():
	game_state_button.texture_normal = BUTTON_CLEARED
