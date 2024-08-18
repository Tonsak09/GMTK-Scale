extends Control

@export var topRect : Control
@export var botRect : Control

@export var transTime : float 
@export var transCurve : Curve
@export var offset : float 

var isAnimating : bool 
var transOut : bool 
var reachedMidPoint : bool 

var timer : float

var posTopOrigin : float
var posBotOrigin : float

func _ready():
	posTopOrigin = topRect.position.y
	posBotOrigin = botRect.position.y
	
	Transition()

func _process(delta):
	if isAnimating:
		timer += delta
		var l = transCurve.sample(timer / transTime) 
		
		if transOut:
			topRect.position = lerp(
				Vector2(topRect.position.x, posTopOrigin - offset), 
				Vector2(topRect.position.x, posTopOrigin), 
				l)
			botRect.position = lerp(
				Vector2(botRect.position.x, posBotOrigin + offset), 
				Vector2(botRect.position.x, posBotOrigin), 
				l)
			
			if l >= 1:
				l = 0.0
				timer = 0.0
				transOut = false 
				reachedMidPoint = true 
		else:
			topRect.position = lerp(
				Vector2(topRect.position.x, posTopOrigin), 
				Vector2(topRect.position.x, posTopOrigin - offset), 
				l)
			
			botRect.position = lerp(
				Vector2(botRect.position.x, posBotOrigin), 
				Vector2(botRect.position.x, posBotOrigin + offset), 
				l)
			
			if l >= 1:
				l = 0.0
				timer = 0.0 
				isAnimating = false  

func Transition():
	
	if !isAnimating:
		timer = transTime # Hackjob
		transOut = true 
		isAnimating = true
		reachedMidPoint = false 
