extends Node

#const SAVE_PATH = "users://savegame.bin" #Normally we'd save in Users
const SAVE_PATH = "res://savegame.bin"

func saveGame():
	#temp file to write inside it to save
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	
	#save as JSON file via dictionary
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"coins": Game.coins,
	}
	var jstr = JSON.stringify(data)
	
	file.store_line(jstr)
	
func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	
	#check if our save file exists
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			#reads inside of JSON file
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.playerHP = current_line["playerHP"]
				Game.coins = current_line["coins"]
	#Godot 4 no longers requires file.close()
