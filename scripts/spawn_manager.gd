extends Node2D

@export var INITIAL_CHECKPOINT: int

var checkPoints: Array;
var currentCheckpoint: int;

func _ready():
	checkPoints = find_children("*", "CheckPoint", false) as Array[CheckPoint];
	currentCheckpoint = INITIAL_CHECKPOINT;
	checkPoints[currentCheckpoint].enable();
	

func on_checkpoint_changed(checkpoint_index: int):
	if currentCheckpoint == checkpoint_index:
		return
	print("Checkpoint changed to:", checkpoint_index);
	currentCheckpoint = checkpoint_index;
	var active_checkpoint = checkPoints[checkpoint_index];
	for checkpoint in checkPoints:
		if checkpoint != active_checkpoint:
			checkpoint.disable();
	active_checkpoint.enable();

func _get_next_spawn_point():
	print("current checkpoint:", currentCheckpoint)
	return checkPoints[currentCheckpoint]._get_next_spawn_point()
