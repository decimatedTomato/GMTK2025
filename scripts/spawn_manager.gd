extends Node2D

var spawnPoints: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	spawnPoints = find_children("*", "Node2D") as Array[Node2D]
	
	
	
func _get_next_spawn_point():
	var index = randi_range(0, spawnPoints.size() - 1)
	var spawnPosition = spawnPoints[index].position
	spawnPoints.remove_at(index)
	return spawnPosition
