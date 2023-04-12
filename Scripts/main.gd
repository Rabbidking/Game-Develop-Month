extends Node2D



func _on_quit_pressed():
	get_tree().quit()



func _on_play_pressed():
	SceneTransition.change_scene_to_file("res://Scenes/node_2d.tscn")
