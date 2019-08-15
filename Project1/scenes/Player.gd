extends KinematicBody2D

var timer = null
var projectile = preload("res://scenes/Projectile.tscn")
var speed = 3

var default_offsetX = 50
var default_offsetY = 75
var offsetX = default_offsetX
var offsetY = default_offsetY

var default_delay = 0.5
var can_shoot = true
var lastShootKeyPressed = Vector2(0,0)

func _ready():
	timer = Timer.new()
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
#
	position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2)
#	scale = Vector2(5,5)
#	rotate(deg2rad(90))

func _process(delta):
#	translate(Vector2(100*delta,0))
#	if(position.x > 1000):
#		position = Vector2(0, get_viewport().size.y/2)
	$AnimatedSprite.play()
	if Input.is_key_pressed(KEY_W) && Input.is_key_pressed(KEY_D):
		self.position.y -= speed
		self.position.x += speed
		$AnimatedSprite.flip_h = false
	elif Input.is_key_pressed(KEY_W) && Input.is_key_pressed(KEY_A):
		self.position.y -= speed
		self.position.x -= speed
		$AnimatedSprite.flip_h = true
	elif Input.is_key_pressed(KEY_S) && Input.is_key_pressed(KEY_D):
		self.position.y += speed
		self.position.x += speed
		$AnimatedSprite.flip_h = false
	elif Input.is_key_pressed(KEY_S) && Input.is_key_pressed(KEY_A):
		self.position.y += speed
		self.position.x -= speed
		$AnimatedSprite.flip_h = true
	elif Input.is_key_pressed(KEY_D):
		self.position.x += speed
		$AnimatedSprite.flip_h = false
	elif Input.is_key_pressed(KEY_A):
		self.position.x -= speed
		$AnimatedSprite.flip_h = true
	elif Input.is_key_pressed(KEY_W):
		self.position.y -= speed
	elif Input.is_key_pressed(KEY_S):
		self.position.y += speed
	else:
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0

	# Prevent player from leaving screen
	position.x = clamp(position.x, 0, get_viewport().size.x)
	position.y = clamp(position.y, 0, get_viewport().size.y) 
	
	if Input.is_key_pressed(KEY_RIGHT) && Input.is_key_pressed(KEY_UP):
		shoot(KEY_RIGHT, KEY_UP)
	elif Input.is_key_pressed(KEY_RIGHT) && Input.is_key_pressed(KEY_DOWN):
		shoot(KEY_RIGHT, KEY_DOWN)
	elif Input.is_key_pressed(KEY_LEFT) && Input.is_key_pressed(KEY_UP):
		shoot(KEY_LEFT, KEY_UP)
	elif Input.is_key_pressed(KEY_LEFT) && Input.is_key_pressed(KEY_DOWN):
		shoot(KEY_LEFT, KEY_DOWN)
	elif Input.is_key_pressed(KEY_RIGHT):
		shoot(KEY_RIGHT, 0)
	elif Input.is_key_pressed(KEY_LEFT):
		shoot(KEY_LEFT, 0)
	elif Input.is_key_pressed(KEY_UP):
		shoot(0, KEY_UP)
	elif Input.is_key_pressed(KEY_DOWN):
		shoot(0, KEY_DOWN)

	# Jump
	if (Input.is_key_pressed(KEY_SPACE) && self.position.y >= -30):
		self.position.y -= speed
	# Descend
	elif Input.is_key_pressed(KEY_SPACE) && self.position.y != 0:
		self.position.y += speed
		
func on_timeout_complete():
	can_shoot = true
	
func shoot(directionX, directionY):
	if can_shoot:
		var p = projectile.instance()
		p.set_name("projectile")
		
		offsetX = default_offsetX
		offsetY = default_offsetY
		if directionX == KEY_LEFT:
			offsetX *= -1
			offsetY = 0
		if directionY == KEY_UP:
			offsetY *= -1
			offsetX = 0
		if directionX == KEY_RIGHT:
			offsetY = 0
		if directionY == KEY_DOWN:
			offsetX = 0
			
		p.position = Vector2(self.position.x + offsetX, self.position.y + offsetY)
		p.add_collision_exception_with(p)
		get_parent().add_child(p)
		
		# Shoot in 45 degree axes
		if directionX == KEY_RIGHT && directionY == KEY_UP:
			p.motionX += p.projSpeed
			p.motionY -= p.projSpeed
			lastShootKeyPressed = Vector2(KEY_RIGHT, KEY_UP)
		elif directionX == KEY_RIGHT && directionY == KEY_DOWN:
			p.motionX += p.projSpeed
			p.motionY += p.projSpeed
			lastShootKeyPressed = Vector2(KEY_RIGHT, KEY_DOWN)
		elif directionX == KEY_LEFT && directionY == KEY_UP:
			p.motionX -= p.projSpeed
			p.motionY -= p.projSpeed
			lastShootKeyPressed = Vector2(KEY_LEFT, KEY_UP)
		elif directionX == KEY_LEFT && directionY == KEY_DOWN:
			p.motionX -= p.projSpeed
			p.motionY += p.projSpeed
			lastShootKeyPressed = Vector2(KEY_LEFT, KEY_DOWN)
		elif directionX == KEY_RIGHT:
			p.motionX += p.projSpeed
			lastShootKeyPressed = Vector2(KEY_RIGHT, 0)
		elif directionX == KEY_LEFT:
			p.motionX -= p.projSpeed
			lastShootKeyPressed = Vector2(KEY_LEFT, 0)
		elif directionY == KEY_UP:
			p.motionY -= p.projSpeed
			lastShootKeyPressed = Vector2(0, KEY_UP)
		elif directionY == KEY_DOWN:
			p.motionY += p.projSpeed
			lastShootKeyPressed = Vector2(0, KEY_DOWN)

		can_shoot = false
		timer.wait_time = default_delay
		timer.start()