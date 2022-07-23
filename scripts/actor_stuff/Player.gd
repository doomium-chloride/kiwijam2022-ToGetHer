extends "res://scripts/actor_stuff/Actor.gd"
const Mob = preload("res://scripts/actor_stuff/Mob.gd")

export var health = 20
export var hunger = 100
export var fly_progress = 0
export var fly_required = 10
export var swim_progress = 0
export var swim_required = 10

export var regenAmount = 1
export var hungerDrainAmount = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Player call")
	print(coords())
	pass # Replace with function body.

func consumeTarget(target: Mob):
	health -= target.damage
	#TODO: Add to progress if applicable
	
	#TODO: Provide buff if applicable
	
	#TODO: Kill target
	GridManager.getTile(GridManager.tilemap.world_to_map(target.position)).tileOccupant = null
	target.queue_free()

func regenHealth():
	health += regenAmount
	
func recoverHealth(recoverAmount: int):
	health += recoverAmount
	
func drainHunger():
	hunger -= hungerDrainAmount
	
func replenishHunger(replenishAmount: int):
	hunger += replenishAmount
	
