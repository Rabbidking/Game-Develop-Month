extends CanvasLayer

@onready var pause = $PauseMenu
#@onready var settings: Control = $Settings
#@onready var drop_down_menu: OptionButton = $Settings/CenterContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/ResolutionButton
#@onready var music = $AudioStreamPlayer2D

#@export var _bus = AudioServer.get_bus_index("Master")

#func _ready() -> void:
#	add_items()	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pause.visible = false
	#settings.visible = false
	if Input.is_action_pressed("ui_cancel"):
		pause.visible = true
		get_tree().paused = true
	if Utils.speedrun_on == true:
		$PauseMenu/Panel/VBoxContainer/SaveButton.disabled = true
		$PauseMenu/Panel/VBoxContainer/LoadButton.disabled = true


func _on_resume_button_pressed():
	pause.visible = false
	get_tree().paused = false


func _on_quit_button_pressed():
	pause.visible = false
	SceneTransition.change_scene_to_file("res://Scenes/main.tscn")


func _on_save_button_pressed():
	Utils.saveGame()


func _on_load_button_pressed():
	Utils.loadGame()
	
#func _on_options_button_pressed():
#	pause.visible = false
#	settings.visible = true
#
#
#func _on_settings_back_pressed():
#	pause.visible = true
#	settings.visible = false
#
#
#
#
#func add_items():
#	drop_down_menu.add_item("1024x546")
#	drop_down_menu.add_item("1152x648")
#	drop_down_menu.add_item("1280x720")
#	drop_down_menu.add_item("1600x900")
#	drop_down_menu.add_item("1920x1080")
#
#
#
#func _on_resolution_button_item_selected(index):
#	var cur_selected = index
#
#	if cur_selected == 0:
#		DisplayServer.window_set_size(Vector2i(1024, 546))
#	if cur_selected == 1:
#		DisplayServer.window_set_size(Vector2i(1152, 648))
#	if cur_selected == 2:
#		DisplayServer.window_set_size(Vector2i(1280, 720))
#	if cur_selected == 3:
#		DisplayServer.window_set_size(Vector2i(1600, 900))
#	if cur_selected == 4:
#		DisplayServer.window_set_size(Vector2i(1920, 1080))
#
##Audio stuff
#func _on_volume_slider_value_changed(value):
#	AudioServer.set_bus_volume_db(_bus, linear_to_db(value))
#
#	if value == 0:
#		AudioServer.set_bus_mute(_bus, true)
#	else:
#		AudioServer.set_bus_mute(_bus, false)
