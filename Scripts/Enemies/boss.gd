extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
#const UI = preload("res://Scripts/UI.gd")
#var ui_stop_timer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var boss_max_health = 100
var boss_current_health = 10
var regen_amount = 5
#var regen_interval = 1.0
signal boss_killed

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

func hurt():
	boss_current_health -= Game.coins
	if boss_current_health <= 0:
		boss_current_health = 0
		#stop the speedrun timer here
		Utils.timer_on = false
		boss_killed.emit()
		#UI._stop_timer()
		
		anim.play("Die")
		await anim.animation_finished
		queue_free()
		SceneTransition.change_scene_to_file("res://Scenes/main.tscn")
		#stop the speedrun timer here
		#go to victory scene
		#SceneTransition.change_scene_to_file("res://Scenes/victory.tscn")
