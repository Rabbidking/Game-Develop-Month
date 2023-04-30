extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#var boss_max_health = 1000000
#var boss_current_health = 500000
#var regen_amount = 10000
#var regen_interval = 1.0
signal boss_killed

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

func hurt():
	var hitspark = $HitSpark
	hitspark.play("default")
	Game.boss_current_health -= Game.coins
	Game.coins = 0
	
	if Game.boss_current_health <= 0:
		Game.boss_current_health = 0
		#stop the speedrun timer here
		Utils.timer_on = false
		boss_killed.emit()
		anim.play("Die")
		await anim.animation_finished
		queue_free()
		SceneTransition.change_scene_to_file("res://Scenes/main.tscn")
