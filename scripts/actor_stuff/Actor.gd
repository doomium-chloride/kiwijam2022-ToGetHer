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
	var newCoords = coords() + dir
	var validMove = !GridManager.isUnwalkableLocation(newCoords)
	if validMove:
		position = GridManager.tilemap.map_to_world(newCoords)
	return validMove

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
