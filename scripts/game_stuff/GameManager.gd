extends Node2D
#class_name Actor
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player: Node2D = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	GridManager.separateTiles()
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
		unit.position = GridManager.tilemap.map_to_world(moveLocation)
		GridManager.getTile(moveLocation).tileOccupant = unit
		GridManager.getTile(prevLocation).tileOccupant = null

