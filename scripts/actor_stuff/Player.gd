extends "res://scripts/actor_stuff/Actor.gd"
#const Mob = load("res://scripts/actor_stuff/Mob.gd")

export var health = 20
export var hunger = 100
export var flyProgress = 0
export var flyRequired = 10
export var swimProgress = 0
export var swimRequired = 10

export var regenAmount = 1
export var hungerDrainAmount = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Player call")
	print(coords())
	print($Area2D.get_overlapping_bodies())
	pass # Replace with function body.

func consumeTarget(target):
	health -= target.damage
	Signals.emit_signal("setHealth", health)

	addToMobProgress(target.mobType)
	#TODO: Provide buff if applicable
	
	GridManager.getTile(GridManager.tilemap.world_to_map(target.position)).tileOccupant = null
	target.queue_free()

func regenHealth():
	health += regenAmount
	Signals.emit_signal("setHealth", health)
	
func recoverHealth(recoverAmount: int):
	health += recoverAmount
	Signals.emit_signal("setHealth", health)
	
func drainHunger():
	hunger -= hungerDrainAmount
	Signals.emit_signal("setHunger", hunger)
	
func replenishHunger(replenishAmount: int):
	hunger += replenishAmount
	Signals.emit_signal("setHunger", hunger)
	
func addToMobProgress(mobType):
	if mobType == MobTypes.BAT:
		increaseProgress(flyProgress, flyRequired)
	elif mobType == MobTypes.CRAB:
		increaseProgress(swimProgress, swimRequired)
		
func increaseProgress(progressType, progressMax):
	if (progressType + 1) < progressMax:
		progressType += 1
