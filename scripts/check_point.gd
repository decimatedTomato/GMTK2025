extends Area2D

class_name CheckPoint
signal checkpoint_reached(newCheckpoint)
var currentSpawn: int = 0;

var INITIAL_OFFSET = Vector2(-35, 0);

var spawnPoints: Array
@export var checkpoint_id: int;

func _ready() -> void:
	spawnPoints = find_children("*", "SpawnPoint", false, true) as Array[Node2D]

func _on_body_entered(_body: Node2D) -> void:
	checkpoint_reached.emit(checkpoint_id);

func _get_next_spawn_point():
	# var spawnOffset = Vector2(INITIAL_OFFSET.x + (currentSpawn % spawnPoints.size() * 30), INITIAL_OFFSET.y);

	var currentSpawnObject = spawnPoints.pop_front();
	var spawnPosition = currentSpawnObject.global_position;
	spawnPoints.push_back(currentSpawnObject);

	print(currentSpawn)
	currentSpawn += 1;
	print(spawnPosition);
	return spawnPosition
