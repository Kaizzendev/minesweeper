extends Node

var file_path : String = "user://save.tres"
var data : Dictionary = {
	time_record = 0
}
func save_data(content):
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_var(JSON.stringify(content),true)
	print("Loaded data:", JSON.stringify(content) )

func load_data():
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		var loadParam=JSON.parse_string(file.get_var(true));
		file.close()
		if loadParam == null:
			print("No se han encontrado datos")
		print("Saved data: ", loadParam)
		return loadParam
