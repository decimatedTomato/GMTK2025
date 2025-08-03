extends Node2D

@export var INITIAL_CHECKPOINT: int
@export var checkPoints: Array[CheckPoint];

var currentCheckpoint:int;

# Called when the node enters the scene tree for the first time.
func _ready():
	currentCheckpoint = INITIAL_CHECKPOINT;

func on_checkpoint_changed(checkpoint: int):
	if checkpoint == currentCheckpoint:
		return
	print("Checkpoint changed to:", checkpoint);
	currentCheckpoint = checkpoint;

func _get_next_spawn_point():
	print("current checkpoint:", currentCheckpoint)
	return checkPoints[currentCheckpoint]._get_next_spawn_point()
