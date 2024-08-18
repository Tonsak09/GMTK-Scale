extends Button

@export var levelText : Label
var gameManager : Node2D

func _ready():
	gameManager = get_tree().get_root().get_child(0)
	
	var labelText = str(get_index()) 
	if labelText.length() == 1:
		labelText = "0" + labelText
	levelText.text = labelText

func _input(event):
	if event.is_action_pressed("Menu"):
		get_parent().get_parent().visible = true 


func SelectLevel():
	if gameManager.currLevelIndex == -1:
		gameManager.LoadLevel(get_index())
	else:
		gameManager.currLevelIndex = get_index() - 1
		gameManager.currLevelInstance.goal.complete = true
	
	get_parent().get_parent().visible = false 
