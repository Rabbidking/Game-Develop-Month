extends CanvasLayer

@onready var coin = get_node("Coins")
@onready var hp = get_node("HP")
@onready var speedrun = get_node("Speedrun")
#const BOSS = preload("res://Scenes/Characters/Enemies/boss.tscn")

var timer = null

func _ready():
	if Utils.timer_on:
		Utils.get_time()
	timer = $Speedrun/SpeedrunTimer
	Boss.boss_killed.connect(_stop_timer)
	
	if Utils.speedrun_on == false:
		speedrun.visible = false
		
	if Boss.boss_current_health <= 0:
		_stop_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#update the player UI
	hp.text = "HP: " + str(Game.playerHP)
	coin.text = "Coins: " + str(Game.coins) + "/" + str(Game.walletMax)
	if Game.coins >= Game.walletMax:
		coin.modulate = Color(1,0,0)
	if Utils.speedrun_on:
		speedrun.text = Utils.get_time()
		
	#if Utils.timer_on == false:
	#	print("Time up!")
		
	update_boss_health()

func update_boss_health():
	var boss_healthbar = $BossHP
	boss_healthbar.value = Boss.boss_current_health
	
	if Boss.boss_current_health >= Boss.boss_max_health or Boss.boss_current_health <= 0:
		$BossRegenTimer.stop()


func _on_boss_regen_timer_timeout():
	print(str(Boss.boss_current_health))
	if Boss.boss_current_health < Boss.boss_max_health:
		Boss.boss_current_health = Boss.boss_current_health + Boss.regen_amount
		if Boss.boss_max_health > Boss.boss_max_health:
			Boss.boss_current_health = Boss.boss_max_health
	print("New Boss Health: " + str(Boss.boss_current_health))

func _stop_timer():
	Utils.game_end_time = Utils.get_time()
	Utils.timer_on = false
	speedrun.modulate(Color(0, 1, 0))
	speedrun.text = Utils.game_end_time
