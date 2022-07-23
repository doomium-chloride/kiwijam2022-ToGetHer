extends "res://scripts/actor_stuff/Actor.gd"

export var alwaysHostile = false
export var sightRange = 10
export var aggroLevel = 0
export var maxAggroLevel = 10
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
		return Utils.randomSelect(validDirs)
	else:
		return Vector2.ZERO
		
func getDir():
	return randomWalk()

func decayAggro():
	aggroLevel = int(max(0, aggroLevel - 1))

func gainAggro():
	aggroLevel = maxAggroLevel

func isHostile():
	return aggroLevel > 0
	
func withinSightRangeOfPlayer(playerCoord : Vector2):
	var distance = position.distance_to(playerCoord)
	return distance <= sightRange
	
func canSeePlayer(playerCoord : Vector2):
	var withintRange = withinSightRangeOfPlayer(playerCoord)
	if withintRange:
		return PathFinding.hasLineOfSight(coords(), playerCoord, GridManager.tilemap)
	else:
		return false

# call this method to get the Mob to execute its turn
func executeTurn():
	# TODO: pass appropriate paramters
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
