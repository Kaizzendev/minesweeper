extends Node


@export var board : Board
@export var hud : HUD



func _ready():
	board.game_lost.connect(_on_game_loose)
	board.game_won.connect(_on_game_won)
	board.flag_change.connect(_on_flag_change)
	hud.set_mine_counter(board.number_of_mines)
	
func _process(delta):
	pass
	
func _on_flag_change(number_of_flags: int):
	hud.set_mine_counter(board.number_of_mines - number_of_flags)

func _on_game_loose():
	hud.game_lost()
	
	
func _on_game_won():
	hud.game_won()
