extends TileMap

@export var board_size_y : int = 10
@export var board_size_x : int = 10
@export var number_of_mines : int = 10

const TILE_SET_ID : int = 0
const TILE_SET_LAYER : int = 0
const ORIGINAL_TILE_SIZE : int = 16
var screen_size : Vector2i 

const CELLS = {
	"1" : Vector2i(0,0),
	"2" : Vector2i(1,0),
	"3" : Vector2i(2,0),
	"4" : Vector2i(3,0),
	"5" : Vector2i(4,0),
	"6" : Vector2i(0,1),
	"7" : Vector2i(1,1),
	"8" : Vector2i(2,1),
	"EMPTY" : Vector2i(3,1),
	"RED_MINE" : Vector2i(4,1),
	"FLAG" : Vector2i(0,2),
	"MINE" : Vector2i(1,2),
	"DEFAULT" : Vector2i(2,2)
}

var tiles_with_mines = []
var touch_position = Vector2()
var hold_duration = 5  # en segundos
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = DisplayServer.window_get_size()
	load_board_configuration(screen_size)
	generate_board(board_size_x,board_size_y)
	print(screen_size)

func _input(event):
	var pressed_tile_coords = local_to_map(get_local_mouse_position())
	
	if !(event is InputEventSingleScreenTap || event is InputEventSingleScreenLongPress):
		return
	print(event)

	if event is InputEventSingleScreenTap:
		on_tile_pressed(pressed_tile_coords)
	if event is InputEventSingleScreenLongPress:
		on_tile_hold(pressed_tile_coords)
	print(pressed_tile_coords)
func load_board_configuration(screen_size: Vector2i):
	
	var max_scale_factor_y: float = float(screen_size.y) / float(screen_size.x)
	var max_scale_factor_x: float = float(screen_size.x) / float(screen_size.y)
	
	if (float(board_size_y)/float(board_size_x) > max_scale_factor_y):
		board_size_y = board_size_x*max_scale_factor_y
		
	if (float(board_size_x)/float(board_size_y) < max_scale_factor_x):
		board_size_x = board_size_y*max_scale_factor_x
		
	var tile_per_screen_x : float = float(screen_size.x) / float(board_size_x)
	var tile_per_screen_y : float = float(screen_size.y) / float(board_size_y)
	
	var scale_factor_x : float = tile_per_screen_x / 16
	var scale_factor_y : float = tile_per_screen_y / 16
	
	scale = Vector2(scale_factor_x,scale_factor_y)
	
func generate_board(board_size_x : int, board_size_y : int):
	for y in board_size_y:
		for x in board_size_x:
			set_cell(TILE_SET_LAYER,Vector2i(x,y),TILE_SET_ID,CELLS.DEFAULT)
			
func generate_mines():
	for i in number_of_mines:
		var mine_tile_coords = Vector2(randi_range(0,board_size_x),randi_range(0,board_size_y))
		
		while tiles_with_mines.has(mine_tile_coords):
			mine_tile_coords = Vector2(randi_range(0,board_size_x),randi_range(0,board_size_y))
			
		tiles_with_mines.append(mine_tile_coords)
		
	for tile in tiles_with_mines:
		erase_cell(TILE_SET_LAYER,tile)
		set_cell(TILE_SET_LAYER,tile,TILE_SET_ID,CELLS.DEFAULT,1)

func on_tile_pressed(coords : Vector2i):
	print("Pulsar")
	
func on_tile_hold(coords : Vector2i):
	print("Mantener")
