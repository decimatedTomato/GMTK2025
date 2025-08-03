extends Area2D

@onready var animated_sprite  = $"AnimatedSpriteWife"

func _process(delta: float) -> void:
	animated_sprite.play("Idle")

func _on_body_entered(body):
	if body is Player:
		body._restart();
