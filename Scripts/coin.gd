extends Area2D

@onready var anim = $AnimatedSprite2D
signal coin_collected

func _on_body_entered(body):
	if body.name == "Player":
		
		#send custom signal to HUD
		coin_collected.emit()
		
		#Animation logic if we have animation frames for the coin disappearing
		#anim.play("Collected")
		#await.anim.animation_finished	#waits until this signal is called before freeing the queue
		#body.add_coin()
		#queue_free()
		
		
		#tweening. We're changing the position of the coin to go upwards and then disappear 
		#(read:change alpha) when collected
		var tween = create_tween()
		tween.tween_property(self, "position", position + Vector2(0, -90), 0.5)
		tween.tween_property(self, "modulate:a", 0.0, 0.5)
		#ADD COINS TO PLAYER BEFORE CALLING QUEUE FREE
		body.add_coin()
		tween.tween_callback(self.queue_free)
