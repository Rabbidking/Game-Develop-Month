extends Node2D


func _on_quit_pressed():
	get_tree().quit()



func _on_play_pressed():
	if Utils.speedrun_on:
		Utils.timer_on = true
		Utils.game_start_time = Time.get_ticks_msec()
	SceneTransition.change_scene_to_file("res://Scenes/node_2d.tscn")
