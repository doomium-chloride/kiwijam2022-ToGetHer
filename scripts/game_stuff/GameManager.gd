extends Node2D
const Mob = preload("res://scripts/actor_stuff/Mob.gd")
const Player = preload("res://scripts/actor_stuff/Player.gd")
#class_name Actor
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player: Node2D = $Icon
onready var testMob: Mob = $TestMob

# Called when the node enters the scene tree for the first time.
func _ready():
	GridManager.separateTiles()
	GridManager.getTile(GridManager.tilemap.world_to_map(testMob.position)).tileOccupant = testMob
	#GridManager.test()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if event.is_action_pressed("ui_left"):
		moveUnit(player, player.coords(), player.coords() + Vector2.LEFT)
	elif event.is_action_pressed("ui_right"):
		moveUnit(player, player.coords(), player.coords() + Vector2.RIGHT)
	elif event.is_action_pressed("ui_up"):
		moveUnit(player, player.coords(), player.coords() + Vector2.UP)
	elif event.is_action_pressed("ui_down"):
		moveUnit(player, player.coords(), player.coords() + Vector2.DOWN)
	
func moveUnit(unit, prevLocation: Vector2, moveLocation: Vector2):
	if GridManager.isWalkableLocation(moveLocation): 
		var destinationPos = GridManager.tilemap.map_to_world(moveLocation)
		if unit is Player:
			var mob = GridManager.getTile(GridManager.tilemap.world_to_map(destinationPos)).tileOccupant
			if mob != null:
				player.consumeTarget(mob)
	
		unit.position = destinationPos
		GridManager.getTile(moveLocation).tileOccupant = unit
		GridManager.getTile(prevLocation).tileOccupant = null

