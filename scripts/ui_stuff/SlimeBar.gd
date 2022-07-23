extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var value = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("decayHunger", self, "decayHunger")
	Signals.connect("restoreHunger", self, "restoreHunger")
	setValue(value)

func setValue(newValue):
	value = newValue
	$TextureProgress.value = newValue

func decayHunger(decay):
	setValue(max(0, value - decay))

func restoreHunger(restore):
	var newHunger = min($TextureProgress.max_value, value + restore)
	setValue(newHunger)
