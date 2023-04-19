extends Node

var num_coins = Game.coins
const BASE_DAMAGE = 10
const COIN_BONUS = 2

func calculate_damage():
	return BASE_DAMAGE + COIN_BONUS * num_coins

func subtract_coins(amount):
	num_coins = max(num_coins - amount, 0)
