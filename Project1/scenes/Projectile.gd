extends KinematicBody2D

var dist = 0
var max_dist = 30000
var projSpeed = 500
var motionX = 0
var motionY = 0
var motion = Vector2(motionX, motionY)

func _physics_process(delta):
	if motionX != 0:
		if motionX < 0:
			if motionY < 0 && self.rotation_degrees == 0:
				rotate(deg2rad(45))
			elif motionY > 0 && self.rotation_degrees == 0:
				rotate(deg2rad(-45))
			self.get_child(1).flip_h = true
		elif motionX > 0:
			if motionY < 0 && self.rotation_degrees == 0:
				rotate(deg2rad(-45))
			elif motionY > 0 && self.rotation_degrees == 0:
				rotate(deg2rad(45))
			self.get_child(1).flip_h = false
			
		dist += abs(motionX)
	if motionY != 0:
		if motionY < 0 && self.rotation_degrees == 0:
			rotate(deg2rad(-90))
		elif motionY > 0 && self.rotation_degrees == 0:
			rotate(deg2rad(90))
		dist += abs(motionY)
	motion = Vector2(motionX, motionY)
	
	var collisionInfo = move_and_collide(motion*delta)

	if dist > max_dist:
		self.call_deferred("free")
	elif collisionInfo != null:
		get_node("/root/Stage").num_enemy -= 1
		get_node("/root/Stage").score += 1
		get_node("/root/Stage/Score").text = "Score: " + String(get_node("/root/Stage").score)
		
		collisionInfo.collider_shape.get_parent().call_deferred("free")
		self.call_deferred("free")

