extends Area2D


func Collect(area : Area2D):
	var gameManager = get_tree().get_root().get_child(0)
	gameManager.heldCollectibles += 1
	queue_free()
