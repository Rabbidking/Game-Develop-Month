extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var player = get_node("/root/Castle/Player")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const EnemyBullet = preload("res://Scenes/Objects/bullet.tscn")

var hurtSounds = [load("res://Assets/Audio/SFX/Breath 1_1.wav"), load("res://Assets/Audio/SFX/Demon 3 - Short 04.wav"), load("res://Assets/Audio/SFX/Demon 3 - Short 11.wav")]


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var hit_cooldown = false
var dead = false
var in_range = false
#var boss_max_health = 1000000
#var boss_current_health = 500000
#var regen_amount = 10000
#var regen_interval = 1.0
#signal boss_killed

func _physics_process(delta):
	if dead == false:
		if $Hit_Range.is_colliding() and hit_cooldown == false:
			anim.play("Stomp")
			$Hit_Animation.play("Hit")
			hit_cooldown = true
			$Cooldown.start()
			
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
		
		else:
			anim.play("default")

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


func _on_hurt_box_body_entered(body):
	if body.get_collision_layer_value(1) and dead == false:
		if body.has_method("hurt"):
			body.hurt()


func _on_cooldown_timeout():
	hit_cooldown = false

func fire_bullet():
	#var main = get_tree().current_scene
	var enemyBullet = EnemyBullet.instantiate()
	var root = get_tree().get_root()
	var current_scene = root.get_child(root.get_child_count()-1)
	#main.add_child(enemyBullet)
	current_scene.call_deferred("add_child", enemyBullet)
	#current_scene.add_child(enemyBullet)
	var direction = player.global_position - global_position
	direction = direction.normalized()
	enemyBullet.position = global_position 
	enemyBullet.rotation = direction.angle()


func _on_shoot_timer_timeout():
	if in_range == true:
		fire_bullet()


func _on_range_detect_body_entered(body):
	if body.get_collision_layer_value(1) and dead == false:
		in_range = true
		fire_bullet()
		$Shoot_Timer.start()
		anim.play("Chomp")


func _on_range_detect_body_exited(body):
	if body.get_collision_layer_value(1):
		in_range = false
		$Shoot_Timer.stop()
