extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var value = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	setValue(value)

func setValue(newValue):
	value = newValue
	$TextureProgress.value = newValue

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
