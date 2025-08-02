extends Node

@export var shadow_scene: PackedScene
var score

func _ready():
	$Player.position = $SpawnManager._get_next_spawn_point()

func _on_restart():
	_create_shadow_with_path()
	$Player._reset()
	$Player.position = $SpawnManager._get_next_spawn_point()
	get_tree().call_group("shadows", "_reset")
	$Player.show()
	
	
func _create_shadow_with_path():
	$ShadowPositionTimer.stop()
	var positionArray = $Player.positionArray
	var shadow = shadow_scene.instantiate()
	shadow.position = positionArray[0]
	add_child(shadow)
	shadow._setup_shadow(positionArray, $ShadowPositionTimer.wait_time)
	$ShadowPositionTimer.start()
	
func _process(delta):
	pass
	
	
	
