extends Node2D

@export var shipParent : Node2D

var timer : float 

func _ready():
	timer = PI / 2.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var velLS = min(10.0, abs(shipParent.vel.length_squared() / 100.0)) 
	timer += delta * velLS
	
	look_at(global_position + shipParent.vel)
	
	if velLS >= 0.01:
		rotate(sin(timer) * 0.1)
