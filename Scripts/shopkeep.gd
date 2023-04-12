extends Area2D


func _on_body_entered(body):
	if body.name == "Player":
		get_tree().paused = true
		#get_node("res://Scenes/Characters/Player.tscn").play("Idle")
		get_node("Shop/Anim").play("TransIn")

#func purchase_upgrade(multiplier):
#	Game.coin_multipliers.append(multiplier)
