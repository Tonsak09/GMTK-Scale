extends Node2D

@export var shipParent : Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(global_position + shipParent.vel)
