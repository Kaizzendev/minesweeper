extends TileMap

var board_size_y : int
var board_size_x : int
var screen_size : Vector2i

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = DisplayServer.window_get_size()
	load_board_configuration(screen_size)
	generate_board(8,8)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_board_configuration(screen_size: Vector2i):
	board_size_x = 8
	board_size_y = 8
	var cell_pixels_size_y = screen_size.y / board_size_y
	var cell_pixels_size_x = screen_size.x / board_size_x
	tile_set.tile_size = Vector2i(cell_pixels_size_x,cell_pixels_size_y)
	
func generate_board(board_size_x : int, board_size_y : int):
	for x in board_size_x:
		for y in board_size_y:
			set_cell(0,Vector2i(x,y),0,Vector2i(0,0))
