extends CharacterBody2D

@export var health = 10
@export var SPEED = 300.0

@onready var anim = $AnimatedSprite2D
#const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	var poof = $Poof

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

func hurt():
	var hitspark = $HitSpark
	hitspark.play("default")
	health -= 10
	if health <= 0:
		die()

func die():
	anim.play("die")
	await anim.animation_finished
	anim.visible = false
	var poof = load("res://Scenes/poof.tscn").instantiate()
	self.add_child(poof)
	poof.play("default")
	await poof.animation_finished
	queue_free()
	
