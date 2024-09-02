extends TileMap

class_name Board

var board_size_y : int = GameOptionsManager.board_size_y
var board_size_x : int = GameOptionsManager.board_size_x
var number_of_mines : int = GameOptionsManager.number_of_mines
@onready var hud = $HUD

signal flag_change(number_of_flags)
signal game_lost
signal game_won 

const TILE_SET_ID : int = 0
const TILE_SET_LAYER : int = 0
const ORIGINAL_TILE_SIZE : int = 16
var screen_size : Vector2i 

var is_game_finished : bool = false
var number_of_flags : int = 0
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
var cells_checked_recursively = []
var tiles_with_flags = []

func _ready():
	var safe_area = DisplayServer.get_display_safe_area().size
	var screen_size = DisplayServer.window_get_size()
	
	hud.notch_panel.custom_minimum_size = Vector2(safe_area.x, screen_size.y - safe_area.y)
	position.y = hud.panel_container.size.y + hud.notch_panel.custom_minimum_size.y
	
	load_board_configuration(Vector2i(screen_size.x,screen_size.y - (hud.panel_container.size.y + hud.notch_panel.custom_minimum_size.y)))
	generate_board(board_size_x,board_size_y)

func _input(event):
	var pressed_tile_coords = local_to_map(get_local_mouse_position())
	
	if !(event is InputEventSingleScreenTap || event is InputEventSingleScreenLongPress):
		return

	if event is InputEventSingleScreenTap:
		if !GameOptionsManager.is_mine_swap:
			on_tile_pressed(pressed_tile_coords)
		else:
			on_tile_hold(pressed_tile_coords)
	if event is InputEventSingleScreenLongPress:
		if !GameOptionsManager.is_mine_swap:
			on_tile_hold(pressed_tile_coords)
		else:
			on_tile_pressed(pressed_tile_coords)
		
	print(pressed_tile_coords)
	
func load_board_configuration(screen_size: Vector2i):
	var max_scale_factor_y: float = float(screen_size.y) / float(screen_size.x)
	var max_scale_factor_x: float = float(screen_size.x) / float(screen_size.y)
	
	board_size_x -= 1
	board_size_y -= 1
	
	if (float(board_size_y)/float(board_size_x) > max_scale_factor_y):
		board_size_y = board_size_x*max_scale_factor_y
		
	if (float(board_size_x)/float(board_size_y) < max_scale_factor_x):
		board_size_x = board_size_y*max_scale_factor_x
		
	var tile_per_screen_x : float = float(screen_size.x) / float(board_size_x)
	var tile_per_screen_y : float = float(screen_size.y) / float(board_size_y)
	
	var scale_factor_x : float = tile_per_screen_x / 16
	var scale_factor_y : float = tile_per_screen_y / 16
	
	scale = Vector2(scale_factor_x,scale_factor_y)
	print("Tamaño tablero x: ", board_size_x)
	print("Tamaño tablero y: ", board_size_y)
func generate_board(board_size_x : int, board_size_y : int):
	for y in board_size_y:
		for x in board_size_x:
			set_cell(TILE_SET_LAYER,Vector2i(x,y),TILE_SET_ID,CELLS.DEFAULT)
	
	generate_mines()

func generate_mines():
	for i in number_of_mines:
		var mine_tile_coords = Vector2(randi_range(0,board_size_x -1),randi_range(0,board_size_y -1))
		
		while tiles_with_mines.has(mine_tile_coords):
			mine_tile_coords = Vector2(randi_range(0,board_size_x -1),randi_range(0,board_size_y -1))
			
		tiles_with_mines.append(mine_tile_coords)
	print(tiles_with_mines)
		
	for tile in tiles_with_mines:
		erase_cell(TILE_SET_LAYER,tile)
		set_cell(TILE_SET_LAYER,tile,TILE_SET_ID,CELLS.DEFAULT,1)

func on_tile_pressed(coords : Vector2i):
	if is_game_finished:
		return
	if tiles_with_flags.any(func(tile): return tile.x == coords.x && tile.y == coords.y):
		return
	if cells_checked_recursively.any(func(tile): return tile.x == coords.x && tile.y == coords.y):
		return
	if tiles_with_mines.any(func(tile): return tile.x == coords.x && tile.y == coords.y):
		loose(coords)
		
	cells_checked_recursively.append(coords)
	
	handle_tile_data(coords,true)
	
func on_tile_hold(coords : Vector2i):
	place_flag(coords)
	
func set_tile_cell(cell_coord, cell_type):
	set_cell(TILE_SET_LAYER, cell_coord, TILE_SET_ID, CELLS[cell_type])

func handle_tile_data(cell_coord: Vector2i, should_stop_after_mine: bool = false):
	var tile_data = get_cell_tile_data(TILE_SET_LAYER,cell_coord)
	
	if tile_data == null:
		return
		
	
	var tile_has_mine = tile_data.get_custom_data("has_mine") 
	
	if tile_has_mine && should_stop_after_mine:
		return
	
	var mine_count = get_surrounding_cells_mine_count(cell_coord)
	
	if mine_count == 0:
		set_tile_cell(cell_coord, "EMPTY")
		var surrounding_cells = get_surrounding_cells_to_check(cell_coord)
		for cell in surrounding_cells:
			handle_surrounding_cell(cell)
	else:
		set_tile_cell(cell_coord, "%d" % mine_count)

func handle_surrounding_cell(cell_coord: Vector2i):
	if cells_checked_recursively.has(cell_coord):
		return
		
	cells_checked_recursively.append(cell_coord)
	handle_tile_data(cell_coord)

func get_surrounding_cells_mine_count(cell_coord: Vector2i) -> int:
	var mine_count = 0
	var sourrounding_cells = get_surrounding_cells_to_check(cell_coord)
	
	for cell in sourrounding_cells:
		var tile_data = get_cell_tile_data(TILE_SET_LAYER,cell)
		if tile_data and tile_data.get_custom_data("has_mine") || get_cell_atlas_coords(TILE_SET_LAYER,cell) == CELLS.FLAG:
			mine_count += 1
			
	return mine_count
	
func get_surrounding_cells_to_check(current_cell: Vector2i) -> Array:
	var target_cell
	var surrounding_cells = []
	
	for y in 3:
		for x in 3:
			if x == 1 and y == 1:
				continue
			target_cell = current_cell + Vector2i(x - 1, y - 1)
			surrounding_cells.append(target_cell)
	
	return surrounding_cells

func loose(coords: Vector2i):
	var sw : bool = true
	is_game_finished = true
	for tile : Vector2i in tiles_with_mines:
		await get_tree().create_timer(0.01).timeout
		if(sw):
			set_tile_cell(coords,"RED_MINE")
			sw = false
		if !(tile == coords):
			set_tile_cell(tile, "MINE")
	if GameOptionsManager.can_vibrate:
		Input.vibrate_handheld()
	game_lost.emit()

func place_flag(coords: Vector2i):
	if is_game_finished:
		return
	var tile_data = get_cell_tile_data(TILE_SET_LAYER,coords)
	var atlas_coords = get_cell_atlas_coords(TILE_SET_LAYER,coords)
	var is_empty_cell = atlas_coords == Vector2i(2,2)
	var is_flag_cell = atlas_coords == Vector2i(0,2)
		
	if is_flag_cell:
		set_tile_cell(coords, "DEFAULT")
		tiles_with_flags.erase(coords)
		number_of_flags -= 1
	if is_empty_cell:
		if number_of_flags == number_of_mines:
			return
		set_tile_cell(coords, "FLAG")
		tiles_with_flags.append(coords)
		if GameOptionsManager.can_vibrate:
			Input.vibrate_handheld(200)
		number_of_flags += 1
		
	flag_change.emit(number_of_flags)
	print(coords, " flagged")
	
	var count = 0
	for flag in tiles_with_flags:
		for mine in tiles_with_mines:
			if (flag.x == mine.x && flag.y == mine.y):
				count += 1
	
	if count == tiles_with_mines.size():
		win_game()
	
func win_game():
	is_game_finished = true
	game_won.emit()
	
