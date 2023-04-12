extends Node

var playerHP = 10
#var coin_multipliers = [1, 2, 4]
var coin_multipliers = [1]
#var coins = 0
var coins = 1000

var items = {
	0: {
		"Name": "2x Multiplier",
		"Des": "Doubles the value of all coins!",
		"Cost": 10,
		"Type": "Multiplier",
		"Multiplier Num": 2,
		"Icon": preload("res://Assets/Icons/x2.png")
	},
	1: {
		"Name": "4x Multiplier",
		"Des": "Quadruples the value of all coins! It stacks!",
		"Cost": 100,
		"Type": "Multiplier",
		"Multiplier Num": 4,
		"Icon": preload("res://Assets/Icons/x4.png")
	}
#	2: {
#		"Name": "Attack Upgrade",
#		"Des": "Adds +1 to your attack!",
#		"Cost": 50,
#		"Type": "Attack"
#	},
#	3: {
#		"Name": "Health Container",
#		"Des": "Gives you additional health!"
#		"Cost": 100
#	}
}

var inventory = {
	0: {
		"Name": "2x Multiplier",
		"Des": "Doubles the value of all coins!",
		"Cost": 10,
		"Type": "Multiplier",
		"Multiplier Num": 2,
		"Icon": preload("res://Assets/Icons/x2.png"),
		"Count": 1
	},
}
