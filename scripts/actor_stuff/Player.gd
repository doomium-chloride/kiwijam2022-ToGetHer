extends "res://scripts/actor_stuff/Actor.gd"
const Mob = preload("res://scripts/actor_stuff/Mob.gd")

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
	pass # Replace with function body.

func consumeTarget(target: Mob):
	if target != null:
		health -= target.damage

		addToMobProgress(target.mobType)
		#TODO: Provide buff if applicable
		
		#GridManager.getTile(GridManager.tilemap.world_to_map(target.position)).tileOccupant = null
		target.currentTile().tileOccupant = null
		target.queue_free()

func regenHealth():
	health += regenAmount
	
func recoverHealth(recoverAmount: int):
	health += recoverAmount
	
func drainHunger():
	hunger -= hungerDrainAmount
	
func replenishHunger(replenishAmount: int):
	hunger += replenishAmount
	
func addToMobProgress(mobType):
	if mobType == MobTypes.BAT:
		if flyProgress < flyRequired:
			flyProgress += 1
	elif mobType == MobTypes.CRAB:
		if swimProgress < swimRequired:
			swimProgress += 1
		
