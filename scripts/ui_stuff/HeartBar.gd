extends Control

const maxValue = 20
export var value = 20

var hearts : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	initHeartsArray()
	update()

func initHeartsArray():
	# Clear array
	hearts = []
	# top layer
	hearts.append($TopLayer/Heart01)
	hearts.append($TopLayer/Heart02)
	hearts.append($TopLayer/Heart03)
	hearts.append($TopLayer/Heart04)
	hearts.append($TopLayer/Heart05)
	# bottom layer
	hearts.append($BottomLayer/Heart01)
	hearts.append($BottomLayer/Heart02)
	hearts.append($BottomLayer/Heart03)
	hearts.append($BottomLayer/Heart04)
	hearts.append($BottomLayer/Heart05)

func update():
	var hp = value
	for heart in hearts:
		if hp >= 2:
			heart.setFull()
		elif hp == 1:
			heart.setHalf()
		else:
			heart.setEmpty()
		hp = max(0, hp-2)

func setValue(hp):
	value = hp
	update()

func increaseHp(increase):
	var newHp = min(maxValue, value + increase)
	setValue(newHp)

func decreaseHp(decrease):
	var newHp = max(0, value - decrease)
	setValue(newHp)
