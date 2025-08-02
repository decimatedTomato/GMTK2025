extends Node2D

var isUIPaused = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

		
func _input(event):
	if isUIPaused == false and (Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right")):
		_unpause()

func _unpause():
	get_tree().paused = false
	
func _pause():
	get_tree().paused = true
