extends Node2D

var Coin = preload("res://Scenes/Objects/coin.tscn")



func _on_timer_timeout():
	var coinTemp = Coin.instantiate()
	add_child(coinTemp)
