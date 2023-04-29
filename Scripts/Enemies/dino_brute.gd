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
		$Detect_Range.enabled = false
		$Detect_Range2.enabled = false
		$Cooldown.start()

	if $Detect_Range.is_colliding() and attacking == false:
		anim.play("walk")
		print("walk")
		$AnimatedSprite2D.flip_h = false
		$Hit_Box/Hit_Box_Collision.position = Vector2(-10, 20.25)
		$Hit_Range.target_position = Vector2(-35, 0)
		velocity.x -= 2
	
	if $Detect_Range2.is_colliding() and attacking == false:
		anim.play("walk")
		$AnimatedSprite2D.flip_h = true
		$Hit_Box/Hit_Box_Collision.position = Vector2(10, 20.25)
		$Hit_Range.target_position = Vector2(35, 0)
		velocity.x += 2
	
	
	if not $Detect_Range.is_colliding() and not $Detect_Range2.is_colliding() and attacking == false and not $Hit_Range.is_colliding():
		$AnimatedSprite2D.play("idle")
		
	move_and_slide()


func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.play("idle")
	attacking = false



func _on_hit_box_body_entered(body):
	if body.get_collision_layer_value(1):
		if body.has_method("hurt"):
			body.hurt()


func _on_cooldown_timeout():
	$Detect_Range.enabled = true
	$Detect_Range2.enabled = true
	hit_cooldown = false
