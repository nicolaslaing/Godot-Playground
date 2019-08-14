extends KinematicBody2D

var timer

# Called when the node enters the scene tree for the first time.
func _ready():
#	timer = Timer.new()
#	timer.connect("timeout", self, "tick")
#	add_child(timer)
#	timer.wait_time = 0.2
#	timer.start()
#
	position = Vector2(128, 128)
#	scale = Vector2(5,5)
#	rotate(deg2rad(90))
	
	set_process(true)
	
#func _process(delta):
#	translate(Vector2(100*delta,0))
#	if(position.x > 1000):
#		position = Vector2(0, get_viewport().size.y/2)