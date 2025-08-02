extends Area2D

var positions = []
var currentIndex
var timeBetweenPoints
var elapsed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if currentIndex >= positions.size() - 1:
		hide()
		set_process(false)
		return

	elapsed += delta
	var t = min(elapsed / timeBetweenPoints, 1.0)

	var start = positions[currentIndex]
	var end = positions[currentIndex + 1]
	position = start.lerp(end, t)

	if t >= 1.0:
		currentIndex += 1
		elapsed = 0.0
	
	
func _setup_shadow(positionArray, timer):
	positions = positionArray
	timeBetweenPoints = timer
	_reset()
	
func _reset():
	currentIndex = 0
	elapsed = 0
	position = positions[0]
	show()
	set_process(true)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("died");
		body.die();
