extends Node

@onready var drop_down_menu: OptionButton = $CanvasLayer/Settings/CenterContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/ResolutionButton
@onready var main: Control = $CanvasLayer/Main
@onready var settings: Control = $CanvasLayer/Settings
@onready var speedrun: CheckButton = $CanvasLayer/Settings/CenterContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/CheckButton
@onready var music = $AudioStreamPlayer2D

@export var master_bus = AudioServer.get_bus_index("Master")
@export var music_bus = AudioServer.get_bus_index("Music")
@export var sfx_bus = AudioServer.get_bus_index("SFX")

func _ready() -> void:
	add_items()
	main.visible = true
	settings.visible = false
	music.play()
	
func _process(delta):
	if Utils.speedrun_on == true:
		$CanvasLayer/Main/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Load.disabled = true
	
	
#Button pressed functions
func _on_quit_pressed():
	get_tree().quit()

func _on_play_pressed():
	if Utils.speedrun_on:
		Utils.timer_on = true
		Utils.game_start_time = Time.get_ticks_msec()
	main.visible = false
	SceneTransition.change_scene_to_file("res://Scenes/Levels/castle.tscn")

func _on_options_pressed():
	main.visible = false
	settings.visible = true

func _on_load_pressed():
	Utils.loadGame()
	
func _on_settings_back_pressed():
	main.visible = true
	settings.visible = false

#Resolution menu functions
func add_items():
	drop_down_menu.add_item("1024x546")
	drop_down_menu.add_item("1152x648")
	drop_down_menu.add_item("1280x720")
	drop_down_menu.add_item("1600x900")
	drop_down_menu.add_item("1920x1080")
	


func _on_resolution_button_item_selected(index):
	var cur_selected = index
	
	if cur_selected == 0:
		DisplayServer.window_set_size(Vector2i(1024, 546))
	if cur_selected == 1:
		DisplayServer.window_set_size(Vector2i(1152, 648))
	if cur_selected == 2:
		DisplayServer.window_set_size(Vector2i(1280, 720))
	if cur_selected == 3:
		DisplayServer.window_set_size(Vector2i(1600, 900))
	if cur_selected == 4:
		DisplayServer.window_set_size(Vector2i(1920, 1080))

#Audio stuff
func _on_master_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, linear_to_db(value))
	
	if value == 0:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)


func _on_check_button_toggled(button_pressed):
	if button_pressed:
		Utils.speedrun_on = true
		speedrun.text = "ON"
	else:
		Utils.speedrun_on = false
		speedrun.text = "OFF"


func _on_music_volume_slider_2_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))
	
	if value == 0:
		AudioServer.set_bus_mute(music_bus, true)
	else:
		AudioServer.set_bus_mute(music_bus, false)


func _on_sfx_volume_slider_3_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(value))
	
	if value == 0:
		AudioServer.set_bus_mute(sfx_bus, true)
	else:
		AudioServer.set_bus_mute(sfx_bus, false)
