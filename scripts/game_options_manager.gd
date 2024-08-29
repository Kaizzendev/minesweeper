extends Node

const difficulty = {"Easy": 10, "Normal": 30, "Hard": 60}
var number_of_mines : int
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func change_difficulty(difficluty: String):
	match  difficluty:
		"Easy":
			number_of_mines = difficulty.Easy
		"Normal":
			number_of_mines = difficulty.Normal
		"Hard":
			number_of_mines = difficulty.Hard
