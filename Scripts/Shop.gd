extends CanvasLayer

var currItem = 0
var select = 0

func _on_close_pressed():
	get_node("Anim").play("TransOut")
	get_tree().paused = false


func switchItem(select):
	#print(Game.items[select])
	for i in range(Game.items.size()):
		if select == i:
			currItem = select
			#print(Game.items[currItem])
			#get_node("Control/AnimSprite").play(Game.items[currItem]["Name"])
			get_node("Control/Name").text = Game.items[currItem]["Name"]
			get_node("Control/Des").text = Game.items[currItem]["Des"]
			get_node("Control/Des").text += "\nCost: " + str(Game.items[currItem]["Cost"])

func _on_next_pressed():
	switchItem(currItem + 1)


func _on_prev_pressed():
	switchItem(currItem - 1)


func _on_buy_pressed():
	var hasItem = false
	if Game.coins > Game.items[currItem]["Cost"]:
		for i in Game.inventory:
			if Game.inventory[i]["Name"] == Game.items[currItem]["Name"]:
				#check item ID to prevent buying multiple
				if Game.inventory[currItem]["Type"] == "Multiplier":
					# We don't wanna buy multipliers more than once
					hasItem = true
					Game.coin_multipliers.append(Game.inventory[currItem]["Multiplier Num"])
					break
				# We already have this item, add +1 to count
				#Game.inventory[i]["Count"] += 1 #add to count
				#hasItem = true
				
		#if hasItem == false or Game.inventory[currItem]["Type"] != "Multiplier":
		if hasItem:
			var tempDict = Game.items[currItem]
			tempDict["Count"] = 1
			Game.inventory[Game.inventory.size()] = tempDict
			#Game.coins -= Game.items[currItem]["Cost"]
		Game.coins -= Game.items[currItem]["Cost"]
	print(Game.inventory)
