extends Node

onready var tilemap : TileMap = get_node("/root/World/TileMap")
onready var foregroundtilemap : TileMap = get_node("/root/World/ForegroundTileMap")
onready var backgroundtilemap : TileMap = get_node("/root/World/BackgroundTileMap")
onready var foremostgroundtilemap : TileMap = get_node("/root/World/ForemostgroundTileMap")

var PathFinding = load("res://scripts/grid_stuff/PathFinding.gd")
var pathFinding = PathFinding.new()
var Tile = load("res://scripts/grid_stuff/Tile.gd")
var walkableTiles = []
var unWalkableTiles = []

enum TILETYPE {
	NORMAL = 0,
	WATER = 1,
	AIR = 2,
	FORBIDDEN = 3
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func separateTiles():
	var cells = tilemap.get_used_cells()
	for cell in cells:
		var idx = tilemap.get_cell(cell[0], cell[1]);
		var colliderShape = tilemap.tile_set.tile_get_shapes(idx)
		var worldPos = Vector2(cell[0] * 16, cell[1] * 16)
		var tile = Tile.new(cell, worldPos, null)
		if len(colliderShape) > 0:
			unWalkableTiles.append(tile)
		else:
			walkableTiles.append(tile)
			
func isUnwalkableTile(tileLocation):
	if unWalkableTiles.has(tileLocation):
		return true
	else:
		return false

func isWalkableLocation(location : Vector2):
	for tile in walkableTiles:
		if location == tile.gridLocation:
			return true
	return false

func isUnwalkableLocation(location : Vector2):
	for tile in unWalkableTiles:
		if location == tile.gridLocation:
			return true
	return false
		
func getTile(location : Vector2):
	for tile in walkableTiles:
		if location == tile.gridLocation:
			return tile
#	for tile in unWalkableTiles:
#		if location == tile.gridLocation:
#			return tile
	return null
	
func getPath(startPos: Vector2, endPos: Vector2):
	pathFinding.initialisePathfinding()
	pathFinding.getPath(startPos, endPos)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
