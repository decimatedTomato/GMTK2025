extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
func _input(event):
	_unpause()

func _unpause():
	get_tree().paused = false
	
func _pause():
	get_tree().paused = true
