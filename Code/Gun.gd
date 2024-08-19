extends Node2D

@export var visual : Node2D
@export var line : Line2D

@export var aimTime : float
@export var holdTime : float 
@export var aimSpeed : float 

@export var widthTarget : float
@export var widthCurve : Curve 
@export var colorA : Color
@export var colorB : Color 

var gameManager
var timer : float 

# Called when the node enters the scene tree for the first time.
func _ready():
	gameManager = get_tree().get_root().get_child(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if timer < aimTime: # Aiming 
		var interp = widthCurve.sample(timer / aimTime)
		line.width = interp * widthTarget
		line.default_color = lerp(colorA, colorB, interp)
		AimTargetting(delta)
	elif timer >= aimTime && timer < aimTime + holdTime:
		#line.width = widthCurve.sample(1.0 - timer / aimTime) * widthTarget
		pass
	else:
		timer = 0.0 # Reset 
	
	timer += delta

func AimTargetting(delta):
	var target = gameManager.currShip.global_position
	var diff = target - global_position
	
	#visual.look_at(target)
	
	
	# gets the angle we want to face
	var angle_to_player = global_position.direction_to(-target).angle()
	# slowly changes the rotation to face the angle
	rotation = move_toward(rotation, angle_to_player, aimSpeed * delta)
	
	
	#line.points = [position, position + diff]

func OnHit(area : Area2D):
	if timer >= aimTime && timer < aimTime + holdTime:
		gameManager.ReloadLevel()
