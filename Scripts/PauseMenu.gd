extends CanvasLayer

@onready var pause = $PauseMenu


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pause.visible = false
	if Input.is_action_pressed("ui_cancel"):
		pause.visible = true
		get_tree().paused = true


func _on_resume_button_pressed():
	pause.visible = false
	get_tree().paused = false


func _on_quit_button_pressed():
	SceneTransition.change_scene_to_file("res://Scenes/main.tscn")


func _on_save_button_pressed():
	Utils.saveGame()


func _on_load_button_pressed():
	Utils.loadGame()
