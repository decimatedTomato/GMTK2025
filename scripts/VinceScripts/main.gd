extends Node

@export var mob_scene: PackedScene
@export var shadow_scene: PackedScene
var score

func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)


func _on_player_hit():
	_create_shadow_with_path()
	
func _create_shadow_with_path():
	$ShadowPositionTimer.stop()
	var positionArray = $Player.positionArray
	var shadow = shadow_scene.instantiate()
	shadow.position = positionArray[0]
	add_child(shadow)
	shadow._setup_shadow(positionArray, $ShadowPositionTimer.wait_time)
	
func _process(delta):
	pass
	
	
	
