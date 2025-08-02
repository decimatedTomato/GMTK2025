extends CharacterBody2D
signal hit

var positionArray = []

# Called when the node enters the scene tree for the first time.
func _ready():
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
func _on_body_entered(_body):
	hide() # Player disappears after being hit.
	hit.emit()
	
func _on_shadow_position_timer_timeout():
	positionArray.append(position);
	#print("time: ", Time.get_ticks_msec())
	
func _reset():
	positionArray = []
	
