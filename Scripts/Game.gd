extends Node

var playerHP = 10
var coin_multipliers = []
#var coins = 0
var coins = 200
var base_coin_value = 1
var walletMax = 200

var items = {
	0: {
		"Name": "2x Multiplier",
		"Des": "Doubles the value of all coins!",
		"Cost": 10,
		"Type": "Multiplier",
		"Multiplier Num": 2,
		"BuyOnce": true,
		"Icon": preload("res://Assets/Icons/x2.png")
	},
	1: {
		"Name": "4x Multiplier",
		"Des": "Quadruples the value of all coins! It stacks!",
		"Cost": 100,
		"Type": "Multiplier",
		"BuyOnce": true,
		"Multiplier Num": 4,
		"Icon": preload("res://Assets/Icons/x4.png")
	},
	2: {
		"Name": "Attack Upgrade",
		"Des": "Adds +1 to your attack!",
		"Cost": 50,
		"Type": "Attack",
		"BuyOnce": false,
		#"Icon": preload("res://icon.svg")
	},
	3: {
		"Name": "Wallet Upgrade 1",
		"Des": "Lets you hold more money!",
		"Cost": 50,
		"Type": "Wallet",
		"BuyOnce": true,
		"Wallet Val": 150
	},
	4: {
		"Name": "Wallet Upgrade 2",
		"Des": "Lets you hold even more money!",
		"Cost": 200,
		"Type": "Wallet",
		"BuyOnce": true,
		"Wallet Val": 400
	}
}

var inventory = {
#	0: {
#		"Name": "2x Multiplier",
#		"Des": "Doubles the value of all coins!",
#		"Cost": 10,
#		"Type": "MultiplierX2",
#		"Multiplier Num": 2,
#		"BuyOnce": true,
#		"Icon": preload("res://Assets/Icons/x2.png"),
#		"Count": 0
#	},
#	1: {
#		"Name": "4x Multiplier",
#		"Des": "Quadruples the value of all coins! It stacks!",
#		"Cost": 100,
#		"Type": "MultiplierX4",
#		"Multiplier Num": 4,
#		"BuyOnce": true,
#		"Icon": preload("res://Assets/Icons/x4.png"),
#		"Count": 0
#	}
}
