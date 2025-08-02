extends Area2D

class_name CheckPoint
signal checkpoint_reached(newCheckpoint)

var spawnPoints: Array
@export var checkpoint_id: int;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnPoints = find_children("*", "Node2D") as Array[Node2D]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body:Node2D) -> void:
	checkpoint_reached.emit(checkpoint_id);

func _get_next_spawn_point():
	var index = randi_range(0, spawnPoints.size() - 1)
	var spawnPosition = spawnPoints[index].global_position
	spawnPoints.remove_at(index)
	print(spawnPosition);
	return spawnPosition
