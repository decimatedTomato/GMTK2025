extends Node2D

@export var sound: AudioStreamPlayer2D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _play_sound() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	sound.play()
