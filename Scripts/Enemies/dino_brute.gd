extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var anim = $AnimatedSprite2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var attacking = false
var hit_cooldown = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if $Hit_Range.is_colliding() and hit_cooldown == false:
		attacking = true
		anim.play("punch")
		$Hit_Animation.play("Hit")
		hit_cooldown = true
	if attacking == false:
		anim.play("idle")

	move_and_slide()


func _on_animated_sprite_2d_animation_finished():
	attacking = false
	anim.play("idle")
	$Cooldown.start()


func _on_hit_box_body_entered(body):
	if body.get_collision_layer_value(1):
		if body.has_method("hurt"):
			body.hurt()


func _on_cooldown_timeout():
	hit_cooldown = false
