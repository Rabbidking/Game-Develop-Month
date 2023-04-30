extends Area2D

@export var speed = 250

func _physics_process(delta):
	position += transform.x * speed * delta
	
func _on_body_entered(body):
	if body.get_collision_layer_value(1):
		if body.has_method("hurt"):
			body.hurt()
			queue_free()
	else:
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
