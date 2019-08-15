extends KinematicBody2D

var motion = Vector2(0,0)
var dist = 0
var max_dist = 20000
var num_enemy = 0
var move_speed = 100

func _process(delta):
	motion = (get_node("/root/Stage/Player").global_position - global_position).normalized()
	var collisionInfo = move_and_collide(motion * move_speed * delta)
	
	if collisionInfo != null:
		self.get_child(1).playing = false
		self.get_child(1).frame = 0
	elif motion.x != 0 || motion.y != 0:
		self.get_child(1).playing = true
	
	if motion.x < 0:
		self.get_child(1).flip_h = true
	elif motion.x > 0:
		self.get_child(1).flip_h = false
	if motion.x != 0:
		dist += motion.x
	if motion.y != 0:
		dist += motion.y
		
	if abs(dist) > max_dist:
		self.call_deferred("free")
		get_node("/root/Stage").num_enemy -= 1