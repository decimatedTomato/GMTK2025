extends Node

@onready var pauseMenu
@onready var pauser
@onready var pauseButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pauseMenu = $"../PauseLayer/PauseMenu"
	pauser = $"../Pauser"
	pauseButton = $"MarginContainer/HBoxContainer/PauseButton"
	pauseButton.focus_mode = Button.FOCUS_NONE
	pauseButton.process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		pass

func _on_pause_button_button_down() -> void:
	if not pauseMenu.is_visible():
		pauser.uiPause()
		pauseMenu.show()
	else:
		pauser.uiUnpause()
		pauseMenu.hide()
