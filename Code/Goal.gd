extends Node2D

@export var goalManage : Node2D

var timer : float 

func ReachedGoal(area : Area2D):
	goalManage.complete = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	rotation = sin(timer) * 0.2
