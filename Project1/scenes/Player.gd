extends KinematicBody2D

var timer = null
var projectile = preload("res://scenes/Projectile.tscn")
var speed = 3
var offset = 0
var default_delay = 0.5
var can_shoot = true

func _ready():
	timer = Timer.new()
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
#
	position = Vector2(128, 128)
#	scale = Vector2(5,5)
#	rotate(deg2rad(90))

func _process(delta):
#	translate(Vector2(100*delta,0))
#	if(position.x > 1000):
#		position = Vector2(0, get_viewport().size.y/2)
	
	if Input.is_key_pressed(KEY_W) && Input.is_key_pressed(KEY_D):
		self.position.y -= speed
		self.position.x += speed
		self.get_child(1).flip_h = false
	elif Input.is_key_pressed(KEY_W) && Input.is_key_pressed(KEY_A):
		self.position.y -= speed
		self.position.x -= speed
		self.get_child(1).flip_h = true
	elif Input.is_key_pressed(KEY_S) && Input.is_key_pressed(KEY_D):
		self.position.y += speed
		self.position.x += speed
		self.get_child(1).flip_h = false
	elif Input.is_key_pressed(KEY_S) && Input.is_key_pressed(KEY_A):
		self.position.y += speed
		self.position.x -= speed
		self.get_child(1).flip_h = true
	elif Input.is_key_pressed(KEY_D):
		self.position.x += speed
		self.get_child(1).flip_h = false
	elif Input.is_key_pressed(KEY_A):
		self.position.x -= speed
		self.get_child(1).flip_h = true
	elif Input.is_key_pressed(KEY_W):
		self.position.y -= speed
	elif Input.is_key_pressed(KEY_S):
		self.position.y += speed
	else:
		self.get_child(1).frame = 0

	if Input.is_key_pressed(KEY_RIGHT):
		shoot(KEY_RIGHT)
	elif Input.is_key_pressed(KEY_LEFT):
		shoot(KEY_LEFT)
	elif Input.is_key_pressed(KEY_UP):
		shoot(KEY_UP)
	elif Input.is_key_pressed(KEY_DOWN):
		shoot(KEY_DOWN)

	# Jump
	if (Input.is_key_pressed(KEY_SPACE) && self.position.y >= -30):
		self.position.y -= speed
	# Descend
	elif Input.is_key_pressed(KEY_SPACE) && self.position.y != 0:
		self.position.y += speed
		
func on_timeout_complete():
	can_shoot = true
	
func shoot(direction):
	if can_shoot:
		var p = projectile.instance()
		p.set_name("projectile")
		p.position = Vector2(self.position.x, self.position.y)
		p.add_collision_exception_with(p)
		get_parent().add_child(p)

		if direction == KEY_RIGHT:
			p.motionX += p.projSpeed
			p.position.x += offset
		elif direction == KEY_LEFT:
			p.motionX -= p.projSpeed
			p.position.x -= offset
		elif direction == KEY_UP:
			p.motionY -= p.projSpeed
			p.position.y -= offset
		elif direction == KEY_DOWN:
			p.motionY += p.projSpeed
			p.position.y += offset

		can_shoot = false
		timer.wait_time = default_delay
		timer.start()