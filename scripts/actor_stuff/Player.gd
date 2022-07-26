extends "res://scripts/actor_stuff/Actor.gd"
const Mob = preload("res://scripts/actor_stuff/Mob.gd")
var SidePanel = load("res://ui/sidepanel.tscn")

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
	var sidePanelUi = SidePanel.instance()
	$Camera2D/CanvasLayer.add_child(sidePanelUi)
	pass # Replace with function body.

func morph(form):
	if form == null:
		$AnimatedSprite.animation = "front"
	if form == MobTypes.BAT:
		$AnimatedSprite.animation = "bat"
	elif form == MobTypes.MOLE:
		$AnimatedSprite.animation = "mole"

func consumeTarget(target: Mob):
	if target != null:
		health -= target.damage
		Signals.emit_signal("setHealth", health)
		if health <= 0:
			Utils.goto_scene("res://ui/gameover.tscn")
			return

		addToMobProgress(target.mobType)
		#TODO: Provide buff if applicable
		
		#GridManager.getTile(GridManager.tilemap.world_to_map(target.position)).tileOccupant = null
		target.currentTile().tileOccupant = null
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
	if hunger <= 0:
		Utils.goto_scene("res://ui/gameover.tscn")
	
func replenishHunger(replenishAmount: int):
	hunger += replenishAmount
	Signals.emit_signal("setHunger", hunger)
	
func addToMobProgress(mobType):
	if mobType == MobTypes.BAT:
		if flyProgress < flyRequired:
			flyProgress += 1
	elif mobType == MobTypes.CRAB:
		if swimProgress < swimRequired:
			swimProgress += 1
		
