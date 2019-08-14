extends AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("animation_finished", self, "on_AnimatedSprite_animation_finished")
	
func on_AnimatedSprite_animation_finished():
	if self.animation == "run":
		animation = "run"
	else:
		animation = "run"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if(self.position.x != 0 && self.position.x != get_viewport().size.x && self.position.y != 0 && self.position.y != get_viewport().size.y):
	if Input.is_key_pressed(KEY_W) && Input.is_key_pressed(KEY_D):
		self.position.y -= 1
		self.position.x += 1
		self.flip_h = false
	elif Input.is_key_pressed(KEY_W) && Input.is_key_pressed(KEY_A):
		self.position.y -= 1
		self.position.x -= 1
		self.flip_h = true
	elif Input.is_key_pressed(KEY_S) && Input.is_key_pressed(KEY_D):
		self.position.y += 1
		self.position.x += 1
		self.flip_h = false
	elif Input.is_key_pressed(KEY_S) && Input.is_key_pressed(KEY_A):
		self.position.y += 1
		self.position.x -= 1
		self.flip_h = true
	elif Input.is_key_pressed(KEY_D):
		self.position.x += 1
		self.flip_h = false
	elif Input.is_key_pressed(KEY_A):
		self.position.x -= 1
		self.flip_h = true
	elif Input.is_key_pressed(KEY_W):
		self.position.y -= 1
	elif Input.is_key_pressed(KEY_S):
		self.position.y += 1
	else:
		self.frame = 0
	
	# Jump
	if (Input.is_key_pressed(KEY_SPACE) && self.position.y >= -30):
		self.position.y -= 2
	# Descend
	elif Input.is_key_pressed(KEY_SPACE) && self.position.y != 0:
		self.position.y += 2
