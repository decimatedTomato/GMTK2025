extends Node2D

@export var INITIAL_CHECKPOINT: int

var checkPoints: Array;
var currentCheckpoint:int;

func _ready():
	checkPoints = find_children("*", "CheckPoint", false) as Array[CheckPoint];
	currentCheckpoint = INITIAL_CHECKPOINT;

func on_checkpoint_changed(checkpoint: int):
	if checkpoint == currentCheckpoint:
		return
	print("Checkpoint changed to:", checkpoint);
	currentCheckpoint = checkpoint;
	for checkpoint_i in checkPoints:
		if checkpoint_i != checkpoint:
			checkPoints[checkpoint_i].disable();
	checkPoints[checkpoint].enable();

func _get_next_spawn_point():
	print("current checkpoint:", currentCheckpoint)
	return checkPoints[currentCheckpoint]._get_next_spawn_point()
