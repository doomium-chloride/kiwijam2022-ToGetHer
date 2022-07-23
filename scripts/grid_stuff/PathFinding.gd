extends Node

var astar = AStar2D.new()
var astar_points_cache = {}

func initialisePathfinding():
	generate_astar_grid(GridManager.walkableTiles)

func generate_astar_grid(walkable_floor_tiles):
	astar_points_cache = {}
	for tile in walkable_floor_tiles:
		var tile_id = astar.get_available_point_id()
		astar.add_point(tile_id, tile.gridLocation)
		astar_points_cache[str([tile.gridLocation.x, tile.gridLocation.y])] = tile_id
	
	for tile in walkable_floor_tiles:
		var tile_id = astar_points_cache[str([tile.gridLocation.x, tile.gridLocation.y])]
		var left_x_key = str([tile.gridLocation.x-1, tile.gridLocation.y])
		if left_x_key in astar_points_cache:
			astar.connect_points(astar_points_cache[left_x_key], tile_id)
		var up_y_key = str([tile.gridLocation.x, tile.gridLocation.y-1])
		if up_y_key in astar_points_cache:
			astar.connect_points(astar_points_cache[up_y_key], tile_id)

func getPath(startPos: Vector2, endPos: Vector2):
	var path = astar.get_point_path(astar_points_cache[str([startPos.x, startPos.y])], astar_points_cache[str([endPos.x, endPos.y])])
	print(path)
	return path
