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

# line of sight algorithm found here: http://www.roguebasin.com/index.php?title=Bresenham%27s_Line_Algorithm
func hasLineOfSight(start_coord: Vector2, end_coord: Vector2, tilemap: TileMap):
	var x1 = start_coord[0]
	var y1 = start_coord[1]
	var x2 = end_coord[0]
	var y2 = end_coord[1]
	var dx = x2 - x1
	var dy = y2 - y1
	# Determine how steep the line is
	var is_steep = abs(dy) > abs(dx)
	var tmp = 0
	# Rotate line
	if is_steep:
		tmp = x1
		x1 = y1
		y1 = tmp
		tmp = x2
		x2 = y2
		y2 = tmp
	# Swap start and end points if necessary and store swap state
	var swapped = false
	if x1 > x2:
		tmp = x1
		x1 = x2
		x2 = tmp
		tmp = y1
		y1 = y2
		y2 = tmp
		swapped = true
	# Recalculate differentials
	dx = x2 - x1
	dy = y2 - y1
	
	# Calculate error
	var error = int(dx / 2.0)
	var ystep = 1 if y1 < y2 else -1

	# Iterate over bounding box generating points between start and end
	var y = y1
	var points = []
	for x in range(x1, x2 + 1):
		var coord = [y, x] if is_steep else [x, y]
		points.append(coord)
		error -= abs(dy)
		if error < 0:
			y += ystep
			error += dx
	
	if swapped:
		points.invert()
	
	#update()
	for point in points:
		if tilemap.get_cell(point[0], point[1]) >= 0:
			return false
	return true
