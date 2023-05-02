extends Node

var playerHP = 3
var coin_multipliers = [1]
var coins = 0
var base_coin_value = 1
var walletMax = 50

var boss_max_health = 500000
var boss_current_health = 500000
var regen_amount = 10000

var items = {
	0: {
		"Name": "2x Multiplier",
		"Des": "Doubles the value of all coins!",
		"Cost": 100,
		"Type": "Multiplier",
		"Multiplier Num": 2,
		"BuyOnce": true,
		"Icon": preload("res://Assets/Icons/X2 Icon.png")
	},
	1: {
		"Name": "4x Multiplier",
		"Des": "Quadruples the value of all coins! It stacks!",
		"Cost": 200,
		"Type": "Multiplier",
		"BuyOnce": true,
		"Multiplier Num": 4,
		"Icon": preload("res://Assets/Icons/X4 Icon.png")
	},
	2: {
		"Name": "6x Multiplier",
		"Des": "Sextuples (heh heh) the value of all coins! Remember, they stack!",
		"Cost": 400,
		"Type": "Multiplier",
		"BuyOnce": true,
		"Multiplier Num": 6,
		"Icon": preload("res://Assets/Icons/X6 Icon.png")
	},
	3: {
		"Name": "8x Multiplier",
		"Des": "Octuples the value of all coins! It's almost like free money!",
		"Cost": 1000,
		"Type": "Multiplier",
		"BuyOnce": true,
		"Multiplier Num": 8,
		"Icon": preload("res://Assets/Icons/X8 Icon.png")
	},
	4: {
		"Name": "10x Multiplier",
		"Des": "The number of coins you get increases tenfold!",
		"Cost": 10000,
		"Type": "Multiplier",
		"BuyOnce": true,
		"Multiplier Num": 10,
		"Icon": preload("res://Assets/Icons/X10 Icon.png")
	},
	5: {
		"Name": "Wallet Upgrade 1",
		"Des": "Lets you hold more money!",
		"Cost": 50,
		"Type": "Wallet",
		"BuyOnce": true,
		"Wallet Val": 150,
		"Icon": preload("res://Assets/Icons/Wallet Upgrade 1.png")
	},
	6: {
		"Name": "Wallet Upgrade 2",
		"Des": "Lets you hold even more money!",
		"Cost": 150,
		"Type": "Wallet",
		"BuyOnce": true,
		"Wallet Val": 400,
		"Icon": preload("res://Assets/Icons/Wallet Upgrade 2.png")
	},
	7: {
		"Name": "Wallet Upgrade 3",
		"Des": "Lets you hold a ton more money!",
		"Cost": 400,
		"Type": "Wallet",
		"BuyOnce": true,
		"Wallet Val": 1000,
		"Icon": preload("res://Assets/Icons/Wallet Upgrade 3.png")
	},
	8: {
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
