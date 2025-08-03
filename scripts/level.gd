extends Node

@export var shadow_scene: PackedScene

signal song1
signal song2
signal song3

var songs = [song1, song2, song3];
# @onready var audioStreamPlayers = [$Song1, $Song2, $Song3];
@export var firstSong: int;
@onready var currentSongSignal = firstSong;

var score = 0

func _ready():
	songs[currentSongSignal].emit();

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
	
func _on_death():
	$Player._reset()
	$Player.position = $SpawnManager._get_next_spawn_point()
	get_tree().call_group("shadows", "_reset")
	$Player.show()
	$Pauser._pause()

func _create_shadow_with_path():
	$ShadowPositionTimer.stop()
	var shadowData = $Player.shadowData
	if len(shadowData) > 0:
		var shadow = shadow_scene.instantiate()
		shadow.position = shadowData[0]["position"]
		add_child(shadow)
		shadow._setup_shadow(shadowData, $ShadowPositionTimer.wait_time)
		$ShadowPositionTimer.start()

func _on_total_run_timer_timeout():
	$Pauser.endGamePause()
	$GameEndPopup/GameEndPanel/MarginContainer/BoxContainer/ScoreLabelMargin/Label.text = "Score: " + str(score)
	$GameEndPopup/GameEndPanel.show()
	