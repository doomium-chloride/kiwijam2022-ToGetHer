extends "res://scripts/actor_stuff/Actor.gd"

var isHostile = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func randomWalk():
	var validDirs = []
	if isValidMove(Vector2.UP):
		validDirs.append(Vector2.UP)
	if isValidMove(Vector2.DOWN):
		validDirs.append(Vector2.DOWN)
	if isValidMove(Vector2.LEFT):
		validDirs.append(Vector2.LEFT)
	if isValidMove(Vector2.RIGHT):
		validDirs.append(Vector2.RIGHT)
	if len(validDirs) > 0:
#		return Utils.randomSelect(validDirs)
		pass
	else:
		return Vector2.ZERO
		
func getDir():
	return randomWalk()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
