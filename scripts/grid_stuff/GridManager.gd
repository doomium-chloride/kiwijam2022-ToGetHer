extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tilemap : TileMap = get_node("/root/World/TileMap")
var Tile = load("res://scripts/grid_stuff/Tile.gd")
var walkableTiles = []
var unWalkableTiles = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func separateTiles():
	var cells = tilemap.get_used_cells()
	for cell in cells:
		var idx = tilemap.get_cell(cell[0], cell[1]);
		var colliderShape = tilemap.tile_set.tile_get_shapes(idx)
		var tile = Tile.new(cell, "mob")
		if len(colliderShape) > 0:
			unWalkableTiles.append(tile)
		else:
			walkableTiles.append(tile)
			
func isUnwalkableTile(tileLocation):
	if unWalkableTiles.has(tileLocation):
		return true
	else:
		return false
	
func test():
	for tile in walkableTiles:
		print(tile.gridLocation)
		print(tile.tileOccupant)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
