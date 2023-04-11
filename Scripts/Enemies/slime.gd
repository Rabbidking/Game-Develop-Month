extends CharacterBody2D

var health = 10
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

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
	$AnimatedSprite2D_Alive.visible = false
	$AnimatedSprite2D_Death.visible = true
	$AnimatedSprite2D_Death.play("Death")

func _on_animated_sprite_2d_death_animation_finished():
	queue_free()
