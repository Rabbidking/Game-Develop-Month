extends CharacterBody2D

var SPEED = 550.0
var JUMP_VELOCITY = -550.0
var coin_manager = preload("res://Scripts/CoinManager.gd")
var attacking = false
var jumping = false
var iframe = false
var hasPlayedSound = false
var coyote_time = 0.4
var can_jump = false
#var jump_max = 2
#var jump_count = 0
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

@onready var bagSwing = $PlayerSFX/bagSwing
@onready var bagHit = $PlayerSFX/bagHit
@onready var player_spawn = $"../PlayerSpawn"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
		
	if Game.playerHP <= 0:
		die()


func _physics_process(delta):
	
	if Game.coins >= Game.walletMax:
		SPEED = 300
		JUMP_VELOCITY = -480.0
	else:
		SPEED = 600
		JUMP_VELOCITY = -550.0
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Handle Jump.
	
	#Code for double jump if we want it
#	if is_on_floor():
#		jump_count = 0
#	else:
#		if jump_count == 0:
#			jump_count += 1
#
#	# Handle Jump.
#	if jump_count < jump_max:
#		if Input.is_action_just_pressed("ui_accept"):
#			velocity.y = JUMP_VELOCITY
#			jump_count += 1
	
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and attacking == false:
#		jumping = true
#		$AnimatedSprite2D.stop()
#		$AnimatedSprite2D.play("Jump")
#		velocity.y = JUMP_VELOCITY

	if is_on_floor() and can_jump == false:
		can_jump = true
	elif can_jump == true and $Coyote.is_stopped():
		$Coyote.start(coyote_time)

	if Input.is_action_just_pressed("jump") and can_jump and attacking == false:
		jumping = true
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.play("Jump")
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if velocity.x > 0 and is_on_floor() and attacking == false and jumping == false:
		$AnimatedSprite2D.play("Walk")
		$AnimatedSprite2D.flip_h = false
		$HitBox/CollisionShape2D.position = Vector2(-15.5, 70.5)
	elif velocity.x < 0 and is_on_floor() and attacking == false and jumping == false:
		$AnimatedSprite2D.play("Walk")
		$AnimatedSprite2D.flip_h = true
		$HitBox/CollisionShape2D.position = Vector2(-85.5, 70.5)
	elif velocity.y > 0 and not is_on_floor() and attacking == false and jumping == false:
		$AnimatedSprite2D.play("Falling")
	if not is_on_floor() and velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	if not is_on_floor() and velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
#	elif Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right") and is_on_floor():
	elif velocity.x == 0 and velocity.y == 0 and is_on_floor() and attacking == false and jumping == false:
		$AnimatedSprite2D.play("Idle")

	move_and_slide()
	
#	if Input.is_action_just_pressed("throw_coin"):
#		throw_coin()
	if Input.is_action_just_pressed("smack"):
		smack()
		
		
#	if Game.playerHP <= 0:
#		Game.playerHP = 0
#		die()
		
func die():
	$PlayerSFX/die.play()
	await $PlayerSFX/die.finished
	$HitBox/CollisionShape2D.disabled = true
	#$AnimatedSprite2D.play("Defeated")
	#await $AnimatedSprite2D.animation_finished
	var coins_to_lose = floor(Game.coins * 0.2)
	Game.coins -= coins_to_lose
	var level_start = $"../PlayerSpawn"
	if level_start:
		position = level_start.position
	else:
		print("Error: LevelStart node not found.")
	Game.playerHP = 10
	get_tree().reload_current_scene()
	
		
func calculate_coin_value():
	var final_coin_value = Game.base_coin_value
	print(str(Game.coin_multipliers))
	for multiplier in Game.coin_multipliers:
		final_coin_value *= multiplier
	return final_coin_value

func add_coin():
	var coin_value = calculate_coin_value()
	Game.coins += coin_value
	print(str(coin_value))

	
		#if SPEED <= 200 or JUMP_VELOCITY >= -100:
		#	SPEED = 200
		#	JUMP_VELOCITY = 100

#func throw_coin():
#	attacking = true
#	$AnimatedSprite2D.play("Toss")
#	# default is Z
#	if Game.coins <= 0:
#		Game.coins = 0
#		return
#	else:
#		Game.coins -= 1
#	print("Num coins: " + str(Game.coins))
	
func smack():
	if not attacking:
		attacking = true
		$AnimatedSprite2D.play("Smack")
		if not hasPlayedSound:
			bagSwing.play()
			hasPlayedSound = true
		#await $AnimatedSprite2D.animation_finished
		$HitBox/CollisionShape2D.disabled = false
	hasPlayedSound = false

func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.play("Idle")
	jumping = false
	attacking = false
	$HitBox/CollisionShape2D.disabled = true
	#print("attack")

func _on_hit_box_body_entered(body):
	if body.get_collision_layer_value(3):
		#print("Hello")
		if body.has_method("hurt"):
			#cue up hitspark
			var hitspark = load("res://Scenes/HitSpark.tscn").instantiate()
			body.add_child(hitspark)
			#play sound
			bagHit.play()
			body.hurt()
			

#func _on_hit(boss):
#	# Create an instance of the CoinManager script
#	var cm = coin_manager.new()
#
#	var damage = cm.calculate_damage() * damage_multiplier
#	boss.take_damage(damage)
#
#	# Subtract coins based on how much damage was done
#	var coins_to_subtract = damage / 10  # For example, subtract 1 coin for every 10 damage dealt
#	cm.subtract_coins(coins_to_subtract)

func lose_money():
	if iframe == false:
		var coins_to_lose = floor(Game.coins * 0.1)
		Game.coins -= coins_to_lose
		print(str(Game.coins))
		
func hurt():
	$AnimatedSprite2D.play("Hurt")
	if iframe == false:
		$PlayerSFX/hit.play()
		Game.playerHP -= 1
		iframe = true
		$IFrame.start()
		$Player_Animation.play("IFrame")
		#if Game.playerHP <= 0:
			#die()


func _on_i_frame_timeout():
	iframe = false
	


func _on_coyote_timeout():
	can_jump = false


func _on_death_plane_body_entered(body):
	die()
