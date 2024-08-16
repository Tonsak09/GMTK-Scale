extends Node2D

@export var gravityWells : Array[Node2D]
@export var viewportSize : Vector2
@export var attractForce : float 

var currRadius : float 
var vel : Vector2

var startPos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	startPos = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	currRadius = ((global_position + viewportSize / 2.0) - get_viewport().get_mouse_position() ).length()
	
	
	var accel = Vector2(0,0)
	
	for well in gravityWells :
		var diff = well.global_position - global_position
		if (diff).length() < currRadius:
			accel += diff.normalized() * attractForce
	vel += accel * delta
	position += vel * delta

func _input(event):
	pass
	#if event.is_action("Restart"):
	#	Restart()

func Restart():
	vel = Vector2.ZERO
	position = startPos
