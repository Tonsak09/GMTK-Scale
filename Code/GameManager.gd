extends Node2D

@export var currShip : Node2D
@export var onScreenDetector : VisibleOnScreenNotifier2D
@export var startPos : Node2D
@export var transitor : Control

@export var levels : Array[PackedScene]

var ship = preload("res://Scenes/Prefabs/Ship.tscn")
var currLevelInstance
var currLevelIndex : int

func _ready():
	currLevelIndex = 0
	LoadLevel(currLevelIndex)

func _input(event):
	if event.is_action_pressed("Restart"):
		Restart()

func _process(delta):
	onScreenDetector.global_position = currShip.global_position 
	
	if currLevelInstance.goal.complete:
		
		transitor.Transition()
		#currShip.vel = Vector2.ZERO
		
		if transitor.reachedMidPoint:
			currLevelIndex += 1
			currLevelInstance.queue_free()
			LoadLevel(currLevelIndex)


func LoadLevel(index : int):
	var levelInstance = levels[index].instantiate()
	add_child(levelInstance)
	currLevelInstance = levelInstance
	
	currShip.gravityWells.clear()
	for i in levelInstance.gravityWells.size():
		currShip.gravityWells.append(levelInstance.gravityWells[i])
	
	Restart()

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
