class_name Player
extends CharacterBody2D

signal hit
signal restart

var DEATH_PENALTY = 10
@export var TotalRunTimer: Timer;

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

var is_dashing = false
var dash_start_pos = 0
var dash_dir = 0
var dash_timer = 0

var shadowData = []

@onready var animation_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jumping
	if Input.is_action_just_pressed("jump") and (is_on_floor() or is_on_wall()):
		velocity.y = jump_velocity

	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= decelerate_on_jump_release

	# Running
	var speed
	if Input.is_action_pressed("run"):
		speed = run_speed
	else:
		speed = walk_speed

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration)
		animation_sprite.flip_h = direction < 0
		#animation_sprite.play("Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed * deceleration)
		animation_sprite.play("Idle")

	# Check for dashing
	if Input.is_action_just_pressed("dash") and direction and not is_dashing and dash_timer <= 0:
		is_dashing = true
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
	# hit.emit()
	restart.emit()
	TotalRunTimer.wait_time -= DEATH_PENALTY


func _on_shadow_position_timer_timeout():
	shadowData.append({"position": position, "flip_h": animation_sprite.flip_h});

func _restart():
	restart.emit()

func _reset():
	shadowData = []
