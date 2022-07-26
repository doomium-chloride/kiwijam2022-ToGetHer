extends Node2D
var Mob = load("res://scripts/actor_stuff/Mob.gd")
var Player = load("res://scripts/actor_stuff/Player.gd")
var Bat = load("res://actors/Bat.tscn")
#class_name Actor
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player: Node2D = $Player
var mobsInVicinity = []
var batUnlocked = false
var moleUnlocked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	GridManager.separateTiles()
	#Spawn bats
	
	#TODO: Get tiles for bats
	var batSpawnableTiles = getSpawnTiles(Vector2(8, 4), Vector2(15, 10))
	var batChosenTiles = chooseSpawnTiles(batSpawnableTiles, 6)
	for tile in batChosenTiles:
		spawnMob(Bat, tile)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	var moveDir = playerInput(event)
	if moveDir != null:
		#Get mobs in vicinity
		getMobsInVicinity()
		
		#Player Action
		if moveDir != Vector2.ZERO:	
			moveUnit(player, player.coords(), player.coords() + moveDir)
		#Enemy Action
		for mob in mobsInVicinity:
			if is_instance_valid(mob):
				print("Testo " + str(mob))
				mob.executeTurn()

		#Post action events
		player.regenHealth()
		player.drainHunger()
		
		print("Player Health: " + str(player.health))
		print("Player Hunger: " + str(player.hunger))
		print("Player Fly Progress: " + str(player.flyProgress))
	elif(event.is_action_pressed("transform_slime")):
		player.morph(null)
	elif(event.is_action_pressed("transform_mole") and moleUnlocked):
		player.morph(MobTypes.MOLE)
	elif(event.is_action_pressed("transform_bat") and batUnlocked):
		player.morph(MobTypes.BAT)
	
func moveUnit(unit, prevLocation: Vector2, moveLocation: Vector2):
	if GridManager.isWalkableLocation(moveLocation): 
		var destinationPos = GridManager.tilemap.map_to_world(moveLocation)
		if unit is Player:
			var mob = GridManager.getTile(GridManager.tilemap.world_to_map(destinationPos)).tileOccupant
			print(mob)
			if mob != null:
				player.consumeTarget(mob)
	
		unit.position = destinationPos
		GridManager.getTile(moveLocation).tileOccupant = unit
		GridManager.getTile(prevLocation).tileOccupant = null

func playerInput(event):
	if event.is_action_pressed("ui_left"):
		return Vector2.LEFT
	elif event.is_action_pressed("ui_right"):
		return Vector2.RIGHT
	elif event.is_action_pressed("ui_up"):
		return Vector2.UP
	elif event.is_action_pressed("ui_down"):
		return Vector2.DOWN
	elif event.is_action_pressed("ui_select"):
		return Vector2.ZERO
	else:
		return null

func getMobsInVicinity():
	var overlaps = player.get_node("Area2D").get_overlapping_areas()
	var newMobs = []
	for collider in overlaps:
		newMobs.append(collider.get_owner())
	mobsInVicinity = newMobs
	print(mobsInVicinity)

func getSpawnTiles(start: Vector2, end: Vector2):
	var spawnTiles = []
	var currentPos = start
	var diff = end - start
	for x in range(diff.x+1):
		for y in range(diff.y+1):
			var tile = GridManager.getTile(currentPos + Vector2(x, y))
			if tile != null:
				if tile.tileType == GridManager.TILETYPE.NORMAL:		
					spawnTiles.append(GridManager.getTile(currentPos + Vector2(x, y)))		
	return spawnTiles
		

func chooseSpawnTiles(availableTiles, requiredAmount):
	var unusedTiles = availableTiles
	var chosenTiles = []
	if len(unusedTiles) == 0:
		return chosenTiles
	for i in range(requiredAmount):
		var randomTile = Utils.randomSelect(unusedTiles)
		chosenTiles.append(randomTile)
		unusedTiles.erase(randomTile)
	return chosenTiles

func spawnMob(mob, tile):
	var mobInstance = mob.instance()
	mobInstance.position = GridManager.tilemap.map_to_world(tile.gridLocation)
	add_child(mobInstance)
