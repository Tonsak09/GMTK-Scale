extends Line2D

@export var radius : float 
@export var viewportSize : Vector2

func _process(delta):
	var currRadius = ((global_position + viewportSize / 2.0) - get_viewport().get_mouse_position() ).length()
	UpdateCirclePoints(currRadius)


#func _input(event):
	#if event is InputEventMouseMotion:
	#	UpdateCirclePoints(((global_position + viewportSize / 2.0) - event.global_position ).length())

func UpdateCirclePoints(mouseLength : float):
	for i in points.size() - 1:
		var ang = float(i) / float(points.size()) * 2.0 * PI
		points[i] = Vector2(cos(ang), sin(ang)) * mouseLength 
	points[points.size() - 1] = points[0] # Complete circle 
