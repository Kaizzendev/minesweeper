extends CanvasLayer

@onready var hud = $"../HUD"

func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")


func _on_resume_button_pressed():
	hud.timer.start()
	hide()
