extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_close_button_pressed():
	get_node("Anim").play("TransOut")
	get_tree().paused = false


func _on_castle_button_pressed():
	$".".visible = false
	SceneTransition.change_scene_to_file("res://Scenes/Levels/castle.tscn")


func _on_cliff_button_pressed():
	$".".visible = false
	SceneTransition.change_scene_to_file("res://Scenes/Levels/cliffs.tscn")


func _on_town_button_pressed():
	$".".visible = false
	SceneTransition.change_scene_to_file("res://Scenes/Levels/town.tscn")


func _on_plains_button_pressed():
	$".".visible = false
	SceneTransition.change_scene_to_file("res://Scenes/Levels/plains.tscn")
