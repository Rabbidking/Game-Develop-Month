extends Node

var playerHP = 1
var coin_multipliers = []
#var coins = 0
var coins = 1
var base_coin_value = 1
var walletMax = 50

var boss_max_health = 1000000
var boss_current_health = 10
var regen_amount = 10000

var items = {
	0: {
		"Name": "2x Multiplier",
		"Des": "Doubles the value of all coins!",
		"Cost": 10,
		"Type": "Multiplier",
		"Multiplier Num": 2,
		"BuyOnce": true,
		"Icon": preload("res://Assets/Icons/X2 Icon.png")
	},
	1: {
		"Name": "4x Multiplier",
		"Des": "Quadruples the value of all coins! It stacks!",
		"Cost": 100,
		"Type": "Multiplier",
		"BuyOnce": true,
		"Multiplier Num": 4,
		"Icon": preload("res://Assets/Icons/X4 Icon.png")
	},
	2: {
		"Name": "Wallet Upgrade 1",
		"Des": "Lets you hold more money!",
		"Cost": 50,
		"Type": "Wallet",
		"BuyOnce": true,
		"Wallet Val": 150,
		"Icon": preload("res://Assets/Icons/Wallet Upgrade 1.png")
	},
	3: {
		"Name": "Wallet Upgrade 2",
		"Des": "Lets you hold even more money!",
		"Cost": 200,
		"Type": "Wallet",
		"BuyOnce": true,
		"Wallet Val": 400,
		"Icon": preload("res://Assets/Icons/Wallet Upgrade 2.png")
	},
	4: {
		"Name": "Wallet Upgrade 3",
		"Des": "Lets you hold a ton more money!",
		"Cost": 500,
		"Type": "Wallet",
		"BuyOnce": true,
		"Wallet Val": 1000,
		"Icon": preload("res://Assets/Icons/Wallet Upgrade 3.png")
	},
	5: {
		"Name": "Wallet Upgrade 4",
		"Des": "Hold INFINITE money! (May not actually hold infinite money, all sales final)",
		"Cost": 1000,
		"Type": "Wallet",
		"BuyOnce": true,
		"Wallet Val": 999999999,
		"Icon": preload("res://Assets/Icons/Wallet Upgrade 4.png")
	},
}

var inventory = {
}
