extends CanvasLayer

@export var pauser: Pauser;

func _on_total_run_timer_timeout() -> void:
	pauser.endGamePause();
	show();
