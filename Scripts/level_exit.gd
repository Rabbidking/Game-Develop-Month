extends Area2D

func _process(delta):
	$LevelSelect.visible = false

func _on_body_entered(body):
	if body.name == "Player":
		$LevelSelect.visible = true
		get_tree().paused = true
		#get_node("../Player/AnimatedSprite2D").play("Idle")
		get_node("LevelSelect/Anim").play("TransIn")
