extends Node

const difficulty_mines = {"Easy": 9, "Normal": 40, "Hard": 99}
const difficulty_size = {"Easy": Vector2i(8,13), "Normal": Vector2i(13,24), "Hard": Vector2i(17,31)}
var number_of_mines : int
var board_size_x: int 
var board_size_y: int
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func change_difficulty(difficluty: String):
	match  difficluty:
		"Easy":
			number_of_mines = difficulty_mines.Easy
			board_size_x = difficulty_size.Easy.x
			board_size_y = difficulty_size.Easy.y
		"Normal":
			number_of_mines = difficulty_mines.Normal
			board_size_x = difficulty_size.Normal.x
			board_size_y = difficulty_size.Normal.y
		"Hard":
			number_of_mines = difficulty_mines.Hard
			board_size_x = difficulty_size.Hard.x
			board_size_y = difficulty_size.Hard.y
