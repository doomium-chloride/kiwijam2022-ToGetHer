extends Control

onready var bar = $TextureProgress

func setEmpty():
	bar.value = 0

func setHalf():
	bar.value = 1

func setFull():
	bar.value = 2
