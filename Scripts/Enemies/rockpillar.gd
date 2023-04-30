extends CharacterBody2D

@export var health = 40
@export var SPEED = 10.0

@onready var anim = $AnimatedSprite2D
@onready var colBox = $CollisionShape2D
@onready var poof = load("res://Scenes/poof.tscn").instantiate()
#const JUMP_VELOCITY = -400.0
@export var direction = -1
@export var cliff_detect = true
var dead = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if direction == 1:
		anim.flip_h = true
	#$Floor_Checker.position.x = 20 * direction
	$Floor_Checker.enabled = cliff_detect


func _physics_process(delta):
	if dead == false:
		if is_on_wall() or not $Floor_Checker.is_colliding() and cliff_detect and is_on_floor():
			direction = direction * -1
			anim.flip_h = not anim.flip_h
			$Floor_Checker.position.x = 75 * direction
			$CollisionShape2D.position.x = 5 * direction
		else:
			velocity.x = 0
			anim.play("move")
			velocity.x += 5 * direction
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta 
			
		move_and_slide()

func hurt():
	var hitspark = $HitSpark
	hitspark.play("default")
	
	#deal double damage if wallet is maxed out
	if Game.coins >= Game.walletMax:
		health -= 20
	else:	
		health -= 10
		
	if health <= 0:
		#$Hurt_Box/Hurt_Box_Collision.disabled = true
		die()

func die():
	print("death")
	#colBox.disabled = true
	dead = true
	set_deferred(str($Hurt_Box/Hurt_Box_Collision.disabled), true)
	set_deferred(str(colBox.disabled), true)
	anim.play("die")
	await anim.animation_finished
	anim.visible = false
	self.add_child(poof)
	poof.scale = Vector2(2,2)
	poof.global_position = global_position + Vector2(0, 5)
	poof.play("default")
	await poof.animation_finished
	queue_free()
	

func _on_hurt_box_body_entered(body):
	if body.get_collision_layer_value(1) and dead == false:
		if body.has_method("hurt"):
			body.hurt()

