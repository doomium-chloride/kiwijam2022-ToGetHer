extends Control


var maxValue = 100
var value = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgress.max_value = maxValue
	$TextureProgress.value = value


func setValue(x):
	value = x
