extends Label

var gameManager

func _ready():
	gameManager = get_tree().get_root().get_child(0)

func _process(delta):
	text = str(gameManager.collectibles) + "/6"
