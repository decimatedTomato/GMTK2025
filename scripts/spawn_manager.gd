extends Node2D

@export var INITIAL_CHECKPOINT: int
var checkPoints: Array;
var currentCheckpoint:int;

# Called when the node enters the scene tree for the first time.
func _ready():
	checkPoints = find_children("*", "CheckPoint", false) as Array[CheckPoint];
	# on_checkpoint_changed(INITIAL_CHECKPOINT);
	currentCheckpoint = INITIAL_CHECKPOINT;

func on_checkpoint_changed(checkpoint: int):
	if checkpoint == currentCheckpoint:
		return
	print("Checkpoint changed to:", checkpoint);
	currentCheckpoint = checkpoint;

func _get_next_spawn_point():
	print("current checkpoint:", currentCheckpoint)
	return checkPoints[currentCheckpoint]._get_next_spawn_point()
