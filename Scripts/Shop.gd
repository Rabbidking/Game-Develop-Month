extends CanvasLayer

var currItem = 0

func _ready():
	switchItem(0)

func _on_close_pressed():
	get_node("Anim").play("TransOut")
	get_tree().paused = false
	switchItem(0)


func switchItem(select):
	#print(Game.items[select])
	for i in range(Game.items.size()):
		if select == i:
			currItem = select
			#print(Game.items[currItem])
			#get_node("Control/AnimSprite").play(Game.items[currItem]["Name"])
			get_node("Control/Item").texture = Game.items[currItem]["Icon"]
			get_node("Control/Name").text = Game.items[currItem]["Name"]
			get_node("Control/Des").text = Game.items[currItem]["Des"]
			get_node("Control/Des").text += "\nCost: " + str(Game.items[currItem]["Cost"])
			
			# Check if we've reached the end of the inventory
			if currItem == Game.items.size() - 1:
				get_node("Control/Next").disabled = true
			else:
				get_node("Control/Next").disabled = false
				
			# Check if we've reached the beginning of the inventory
			if currItem == 0:
				get_node("Control/Prev").disabled = true
			else:
				get_node("Control/Prev").disabled = false

func _on_next_pressed():
	switchItem(currItem + 1)


func _on_prev_pressed():
	switchItem(currItem - 1)


func _on_buy_pressed():
	var hasItem = false
	if Game.coins > Game.items[currItem]["Cost"]:
		for i in Game.inventory:
			if Game.inventory[i]["Name"] == Game.items[currItem]["Name"]:
				# Check item ID to prevent buying multiple
				if Game.inventory[i]["Count"] >= 1:
					# We already have this item, disable the purchase button
					hasItem = true
					get_node("Control/Buy").disabled = true
					break
				# We don't wanna buy multipliers more than once
				if Game.inventory[i]["Type"] == "Multiplier":
					hasItem = true
					Game.coin_multipliers.append(Game.inventory[i]["Multiplier Num"])
					break
				# Add +1 to count if we already have the item but it's not a multiplier
				Game.inventory[i]["Count"] += 1
				hasItem = true
				
		if not hasItem:
			var tempDict = Game.items[currItem]
			tempDict["Count"] = 1
			Game.inventory[Game.inventory.size()] = tempDict
			if Game.items[currItem]["Type"] == "Multiplier":
				Game.coin_multipliers.append(Game.items[currItem]["Multiplier Num"])
		Game.coins -= Game.items[currItem]["Cost"]
		
		if hasItem:
			# If we already have the item, disable the purchase button
			get_node("Control/Buy").disabled = true
	#print(Game.inventory)
	print(Game.coin_multipliers)
