extends CharacterBody2D

@export var health = 10
@export var SPEED = 300.0

@onready var anim = $AnimatedSprite2D
#const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

func hurt():
	health -= 10
	if health <= 0:
		die()

func die():
	#$AnimatedSprite2D_Alive.visible = false
	#$AnimatedSprite2D_Death.visible = true
	#$AnimatedSprite2D_Death.play("Death")
	anim.play("die")
	await anim.animation_finished
	queue_free()
	
