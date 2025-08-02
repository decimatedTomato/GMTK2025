extends Node

@export var shadow_scene: PackedScene

var score = 0

func _ready():
	$Hud/MarginContainer/HBoxContainer/Score.text = str(score)
	$Player.position = $SpawnManager._get_next_spawn_point()
	$Pauser._pause()

func _on_restart():
	_create_shadow_with_path()
	$Player._reset()
	$Player.position = $SpawnManager._get_next_spawn_point()
	get_tree().call_group("shadows", "_reset")
	score += 1
	$Hud/MarginContainer/HBoxContainer/Score.text = str(score)
	$Player.show()
	$Pauser._pause()

func _create_shadow_with_path():
	$ShadowPositionTimer.stop()
	var shadowData = $Player.shadowData
	var shadow = shadow_scene.instantiate()
	shadow.position = shadowData[0]["position"]
	add_child(shadow)
	shadow._setup_shadow(shadowData, $ShadowPositionTimer.wait_time)
	$ShadowPositionTimer.start()
