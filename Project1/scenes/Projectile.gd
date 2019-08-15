extends KinematicBody2D

var dist = 0
var max_dist = 30000
var projSpeed = 500
var motionX = 0
var motionY = 0
var motion = Vector2(motionX, motionY)

func _physics_process(delta):
	if motionX != 0:
		dist += motionX
	if motionY != 0:
		dist += motionY
	motion = Vector2(motionX, motionY)
	
	var collisionInfo = move_and_collide(motion*delta)

	if abs(dist) > max_dist:
		self.call_deferred("free")
	elif collisionInfo != null:
		get_node("/root/Stage").num_enemy -= 1
		get_node("/root/Stage").score += 1
		get_node("/root/Stage/Score").text = "Score: " + String(get_node("/root/Stage").score)
		
		collisionInfo.collider_shape.get_parent().call_deferred("free")
		self.call_deferred("free")

