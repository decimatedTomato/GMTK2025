extends Area2D
class_name CheckPoint

signal checkpoint_reached(newCheckpoint)

var spawnPoints: Array

@export var checkpoint_id: int;

@onready var enabled_sprite := $Enabled;
@onready var disabled_sprite := $Disabled;

func _ready() -> void:
	
	spawnPoints = find_children("*", "SpawnPoint", false, true) as Array[Node2D]

func _on_body_entered(_body: Node2D) -> void:
	checkpoint_reached.emit(checkpoint_id);

func _get_next_spawn_point():
	var currentSpawnObject = spawnPoints.pop_front();
	var spawnPosition = currentSpawnObject.global_position;
	spawnPoints.push_back(currentSpawnObject);
	return spawnPosition

func enable():
	disabled_sprite.hide();
	enabled_sprite.show()

func disable():
	disabled_sprite.show();
	enabled_sprite.hide()
