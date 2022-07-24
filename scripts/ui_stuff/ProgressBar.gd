extends Control

export var formType = MobTypes.FOX

func _ready():
	Signals.connect("progressForm", self, "progress")

func progress(form):
	if form != formType:
		return
	var maxValue = $ProgressBar.max_value
	var currentValue = $ProgressBar.value
	if currentValue >= maxValue:
		return
	var newValue = min(maxValue, currentValue + 1)
	$ProgressBar.value = newValue
	if maxValue == newValue:
		Signals.emit_signal("enableForm", formType)
