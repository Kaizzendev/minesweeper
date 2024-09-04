extends Node

const FILE_PATH = "res://version.txt"

func get_version_number():
	var file = FileAccess.open(FILE_PATH, FileAccess.READ)
	var content=file.get_as_text()
	file.close()
		
	return content
