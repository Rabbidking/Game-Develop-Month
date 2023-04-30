extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var hurtSounds = [load("res://Assets/Audio/SFX/Breath 1_1.wav"), load("res://Assets/Audio/SFX/Demon 3 - Short 04.wav"), load("res://Assets/Audio/SFX/Demon 3 - Short 11.wav")]


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#var boss_max_health = 1000000
#var boss_current_health = 500000
#var regen_amount = 10000
#var regen_interval = 1.0
#signal boss_killed

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

func hurt():
	if Game.coins > 0:
		var hitspark = $HitSpark
		hitspark.play("default")
		anim.play("Chomp")
		$SFX/dragonHurt.stream = hurtSounds[randi() % len(hurtSounds)]
		$SFX/dragonHurt.play()
		Game.boss_current_health -= Game.coins
		Game.coins = 0
		
		if Game.boss_current_health <= 0:
			Game.boss_current_health = 0
			#stop the speedrun timer here
			Utils.timer_on = false
			$SFX/dragonDie.play()
			#boss_killed.emit()
			anim.play("Die")
			await anim.animation_finished
			queue_free()
			SceneTransition.change_scene_to_file("res://Scenes/main.tscn")
	else:
		anim.play("Lick")
		$SFX/dragonLaugh.play()
