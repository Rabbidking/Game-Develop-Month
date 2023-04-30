extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var health = 10
@onready var anim = $AnimatedSprite2D
@onready var colBox = $CollisionShape2D
@onready var poof = load("res://Scenes/poof.tscn").instantiate()
@export var speed = 150
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var attacking = false
var hit_cooldown = false
var dead = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if dead == false:
		if $Hit_Range.is_colliding() and hit_cooldown == false:
			velocity.x = 0
			attacking = true
			anim.play("chomp")
			$SFX/attack.play()
			$Hit_Animation.play("Hit")
			hit_cooldown = true
			$Detect_Range.enabled = false
			$Detect_Range2.enabled = false
			$Cooldown.start()

		if $Detect_Range.is_colliding() and attacking == false:
			anim.play("run")
			$AnimatedSprite2D.flip_h = false
			$Hurt_Box/Hurt_Box_Collision.position = Vector2(-27.5, 12)
			$Hit_Range.target_position = Vector2(-35, 0)
			velocity.x = 0
			velocity.x -= 1 * speed
		
		if $Detect_Range2.is_colliding() and attacking == false:
			anim.play("run")
			$AnimatedSprite2D.flip_h = true
			$Hurt_Box/Hurt_Box_Collision.position = Vector2(27.5, 12)
			$Hit_Range.target_position = Vector2(35, 0)
			velocity.x = 0
			velocity.x += 1 * speed
		
		
		if not $Detect_Range.is_colliding() and not $Detect_Range2.is_colliding() and attacking == false and not $Hit_Range.is_colliding():
			$AnimatedSprite2D.play("idle")
			velocity.x = 0
			
		move_and_slide()


func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.play("idle")
	attacking = false

func _on_cooldown_timeout():
	$Detect_Range.enabled = true
	$Detect_Range2.enabled = true
	hit_cooldown = false

func hurt():
	var hitspark = $HitSpark
	hitspark.play("default")
	$SFX/hit.play()
	#deal double damage if wallet is maxed out
	if Game.coins >= Game.walletMax:
		health -= 20
	else:	
		health -= 10
		
	if health <= 0:
		set_deferred(str($Hurt_Box/Hurt_Box_Collision.disabled), true)
		$AnimatedSprite2D.stop()
		dead = true
		velocity.x = 0
		die()

func die():
	#colBox.disabled = true
	set_deferred(str(colBox.disabled), true)
	anim.play("die")
	$SFX/die.play()
	await anim.animation_finished
	anim.visible = false
	self.add_child(poof)
	poof.global_position = global_position + Vector2(0, -65)
	poof.play("default")
	await poof.animation_finished
	queue_free()


func _on_hurt_box_body_entered(body):
	if body.get_collision_layer_value(1) and dead == false:
		if body.has_method("lose_money"):
			body.lose_money()
		if body.has_method("hurt"):
			body.hurt()

