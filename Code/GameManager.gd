extends Node2D

@export var currShip : Node2D
@export var onScreenDetector : VisibleOnScreenNotifier2D
@export var startPos : Node2D
@export var transitor : Control

@export var levelSelectScreen : Node
@export var levels : Array[PackedScene]

var ship = preload("res://Scenes/Prefabs/Ship.tscn")
var currLevelInstance
var currLevelIndex : int

var isPlaying : bool
var reloading : bool 


var heldCollectibles : int 
var collectibles : int 

func _ready():
	currLevelIndex = -1
	#LoadLevel(currLevelIndex)

func _input(event):
	if event.is_action_pressed("Restart"):
		Restart()
	
	

func _process(delta):
	
	if !isPlaying:
		return 
	
	onScreenDetector.global_position = currShip.global_position 
	
	if currLevelInstance.goal.complete:
		transitor.Transition()
		#currShip.vel = Vector2.ZERO
		
		if transitor.reachedMidPoint:
			currLevelIndex += 1
			currLevelInstance.queue_free()
			LoadLevel(currLevelIndex)
			
			if !reloading:
				collectibles += heldCollectibles
			heldCollectibles = 0
			reloading = false 
			

func ReloadLevel():
	reloading = true 
	currLevelInstance.goal.complete = true
	currLevelIndex -= 1

func LoadLevel(index : int):
	if index == levels.size() - 1:
		levelSelectScreen.visible = true 
	
	
	var levelInstance = levels[index].instantiate()
	add_child(levelInstance)
	currLevelInstance = levelInstance
	
	currShip.gravityWells.clear()
	for i in levelInstance.gravityWells.size():
		currShip.gravityWells.append(levelInstance.gravityWells[i])
	
	Restart()
	isPlaying = true
	currLevelIndex = index

func Restart():
	
	var wells = currShip.gravityWells
	
	var instance = ship.instantiate()
	add_child(instance)
	
	for i in wells.size():
		instance.gravityWells.append(wells[i])
	
	currShip.queue_free()
	currShip = instance
	currShip.global_position = startPos.global_position
	#map = map.new(inst_geo) 
