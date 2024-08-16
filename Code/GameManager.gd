extends Node2D

@export var currShip : Node2D
@export var onScreenDetector : VisibleOnScreenNotifier2D

@export var levels : Array[PackedScene]

var ship = preload("res://Scenes/Prefabs/Ship.tscn")

func _ready():
	LoadLevel(0)

func _input(event):
	if event.is_action_pressed("Restart"):
		Restart()

func _process(delta):
	onScreenDetector.global_position = currShip.global_position 

func LoadLevel(index : int):
	var levelInstance = levels[0].instantiate()
	add_child(levelInstance)
	
	currShip.gravityWells.clear()
	for i in levelInstance.gravityWells.size():
		currShip.gravityWells.append(levelInstance.gravityWells[i])

func Restart():
	
	var wells = currShip.gravityWells
	
	var instance = ship.instantiate()
	add_child(instance)
	
	for i in wells.size():
		instance.gravityWells.append(wells[i])
	
	currShip.queue_free()
	currShip = instance
	#map = map.new(inst_geo) 
