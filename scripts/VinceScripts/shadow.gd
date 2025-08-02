extends Area2D

var positions = []
var currentIndex = 0
var timeBetweenPoints
var elapsed = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
	position = positions[0]
	set_process(true)
