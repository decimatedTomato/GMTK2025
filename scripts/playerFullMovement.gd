class_name Player
extends CharacterBody2D

signal restart
signal death
signal deathSoundPlay

var in_safe_zone = false;
var DEATH_PENALTY = 10
@export var TotalRunTimer: Timer;
@export var TimerText: Label

@export var walk_speed = 600.0
@export var run_speed = 800.0
@export_range(0, 1) var acceleration = 0.1
@export_range(0, 1) var deceleration = 0.1

@export var jump_velocity = -600.0
@export_range(0, 1) var decelerate_on_jump_release = 0.5

@export var dash_speed = 1500.0
@export var dash_max_distance = 600.0
@export var dash_curve : Curve
@export var dash_cooldown = 1.0

@onready var jump_sound: AudioStreamPlayer2D = $JumpSound;
@onready var dash_sound: AudioStreamPlayer2D = $DashSound;
@onready var land_sound: AudioStreamPlayer2D = $LandSound;

var is_in_air = false;

var is_dashing = false
var dash_start_pos = 0
var dash_dir = 0
var dash_timer = 0

var slippedUp := false;

var shadowData = []

@onready var animation_sprite = $AnimatedSprite2D
@onready var particle_emitter = $GPUParticles2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_in_air and is_on_floor():
		is_in_air = false;
		land_sound.play();
		particle_emitter.restart()
	# Jumping
	if Input.is_action_just_pressed("jump") and (is_on_floor() or may_wall_jump()):
		particle_emitter.restart()
		animation_sprite.play("Jump")
		animation_sprite.play("Rise")
		is_in_air = true;
		jump_sound.play()
		velocity.y = jump_velocity

	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= decelerate_on_jump_release

	if velocity.y < 0:
		animation_sprite.play("Fall")

	# Running
	var speed
	if Input.is_action_pressed("run"):
		animation_sprite.play("Run")
		speed = run_speed
	else:
		speed = walk_speed

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration)
		animation_sprite.flip_h = direction < 0
		animation_sprite.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed * deceleration)
		animation_sprite.play("Idle")

	# Check for dashing
	if Input.is_action_just_pressed("dash") and direction and not is_dashing and dash_timer <= 0:
		is_dashing = true
		dash_sound.play();
		dash_start_pos = position.x
		dash_dir = direction
		dash_timer = dash_cooldown

	# Perform dashing
	if is_dashing:
		var current_dist = abs(position.x - dash_start_pos)
		if current_dist >= dash_max_distance or is_on_wall():
			is_dashing = false
		else:
			velocity.x = dash_dir * dash_speed * dash_curve.sample(current_dist / dash_max_distance)
			velocity.y = 0

	# Reduce dash timer
	if dash_timer > 0:
		dash_timer -= delta

	move_and_slide()

func die():
	if (in_safe_zone):
		return

	deathSoundPlay.emit()
	death.emit()
	TotalRunTimer.start(TotalRunTimer.get_time_left() - DEATH_PENALTY)
	TimerText.setTime()


func _on_shadow_position_timer_timeout():
	shadowData.append({"position": position, "flip_h": animation_sprite.flip_h});

func _restart():
	restart.emit()

func _reset():
	shadowData = []

func may_wall_jump():
	return is_on_wall() and not slippedUp

func _on_area_2d_body_entered(_body: Node2D) -> void:
	slippedUp = true;


#func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	#print("6 happened")


func _on_area_2d_body_exited(_body: Node2D) -> void:
	slippedUp = false;

func _on_entered_safe_zone(_body: Node2D) -> void:
	print("entered safe zone")
	in_safe_zone = true;

func _on_exit_safe_zone(_body: Node2D) -> void:
	print("exited safe zone")
	in_safe_zone = false;


#func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	#print("8 happened")
