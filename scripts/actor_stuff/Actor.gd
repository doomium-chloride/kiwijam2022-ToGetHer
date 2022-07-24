extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	# snap to grid
	position = GridManager.tilemap.map_to_world(coords())

func coords():
	return GridManager.tilemap.world_to_map(position)

func currentTile():
	return GridManager.getTile(coords())
	
func isValidMove(dir : Vector2):
	var newCoords = coords() + dir
	return !GridManager.isUnwalkableLocation(newCoords)

func move(dir : Vector2):
	var oldCoords = coords()
	var newCoords = oldCoords + dir
	#var validMove = GridManager.isWalkableLocation(newCoords)
	if GridManager.getTile(newCoords).tileType == GridManager.TILETYPE.NORMAL:
		if GridManager.getTile(newCoords).tileOccupant == null:
			position = GridManager.tilemap.map_to_world(newCoords)
		return true
	return false
