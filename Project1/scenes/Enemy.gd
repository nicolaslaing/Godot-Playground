extends KinematicBody2D

var motion = Vector2(0,0)
var dist = 0
var max_dist = 20000
var num_enemy = 0
var move_speed = 100

func _process(delta):
	# Move towards the player at all times
	motion = (get_node("/root/Stage/Player").global_position - global_position).normalized()
	var collisionInfo = move_and_collide(motion * move_speed * delta)
	
	if motion.x != 0 || motion.y != 0:
		$AnimatedSprite.playing = true
	if collisionInfo != null:
		$AnimatedSprite.playing = false
		$AnimatedSprite.frame = 0
	
	if motion.x < 0:
		$AnimatedSprite.flip_h = true
	elif motion.x > 0:
		$AnimatedSprite.flip_h = false
#	if motion.x != 0:
#		dist += motion.x
#	if motion.y != 0:
#		dist += motion.y
	
	# Delete enemy after a distance
#	if abs(dist) > max_dist:
#		self.call_deferred("free")
#		get_node("/root/Stage").num_enemy -= 1