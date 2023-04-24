extends Node

@onready var game_start_time = 0
var game_end_time = 0
#const SAVE_PATH = "users://savegame.bin" #Normally we'd save in Users
const SAVE_PATH = "res://savegame.bin"
var speedrun_on = true
var timer_on = false

func saveGame():
	#temp file to write inside it to save
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	
	#save as JSON file via dictionary
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"coins": Game.coins,
		"boss_current_health": Boss.boss_current_health
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
				Boss.boss_current_health = current_line["boss_current_health"]
	#Godot 4 no longers requires file.close()
	
func get_time():
	var elapsed_time = Time.get_ticks_msec() - game_start_time
	var minutes = elapsed_time / 1000 / 60
	var seconds = elapsed_time / 1000 % 60
	var msec = elapsed_time % 1000 / 10
	
	if minutes < 10:
		minutes = "0" + str(minutes)
			
	if seconds < 10:
		seconds = "0" + str(seconds)
		
	if msec < 10:
		if msec == 0:
			msec = "00"
		else:
			msec = "0" + str(msec)
		
	
	return str(minutes) + ":" + str(seconds) + ":" + str(msec)
