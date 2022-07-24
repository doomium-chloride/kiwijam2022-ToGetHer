extends Node2D
var Mob = load("res://scripts/actor_stuff/Mob.gd")
var Player = load("res://scripts/actor_stuff/Player.gd")
#class_name Actor
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player: Node2D = $Player
var mobsInVicinity = []

# Called when the node enters the scene tree for the first time.
func _ready():
	GridManager.separateTiles()

	#GridManager.test()
	pass # Replace with function body.


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
		#TODO: Get all mobs within a vicinity and have them act
		
		#Post action events
		player.regenHealth()
		player.drainHunger()
		
		print("Player Health: " + str(player.health))
		print("Player Hunger: " + str(player.hunger))
		print("Player Fly Progress: " + str(player.flyProgress))
	
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
