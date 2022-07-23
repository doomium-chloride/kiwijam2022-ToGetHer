extends Node

# 50% chance
func flipCoin():
	var coin = randi() % 2
	return coin == 0

func randomSelect(array : Array):
	var length = len(array)
	var value = rand_range(0, length)
	var index = int(value)
	return array[index]
