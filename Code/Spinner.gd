extends Node2D

@export var spinSpeed : float 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(spinSpeed * delta)
