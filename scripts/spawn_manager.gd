extends Node2D

var currentCheckpoint:int = 0;
@export var checkPoints: Array[CheckPoint];

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func on_checkpoint_changed(checkpoint: int):
	if checkpoint == currentCheckpoint:
		return
	print("Checkpoint changed to:", checkpoint);
	currentCheckpoint = checkpoint;

func _get_next_spawn_point():
	return checkPoints[currentCheckpoint]._get_next_spawn_point()
