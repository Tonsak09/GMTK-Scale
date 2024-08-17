extends Node2D

var timer : float 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	timer += delta
	rotation = sin(timer) * 0.2
