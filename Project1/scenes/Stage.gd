extends Node2D

var enemy = preload("res://scenes/Enemy.tscn")

var timer = null
var default_delay = 2
var can_spawn = true
var max_enemy = 5
var num_enemy = 0
var move_speed = 100
var signVar = 1
export var score = 0

func _ready():
	timer = Timer.new()
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	
func on_timeout_complete():
	can_spawn = true
	
func _process(delta):
	if can_spawn:
		spawn_enemy()
		can_spawn = false
		timer.wait_time = default_delay
		timer.start()

func switch_sign():
	var rangeNum = 100
	var randNum = randi() % rangeNum
	if randNum < rangeNum/2:
		signVar = -1
	else:
		signVar = 1

func spawn_enemy():
	var inst_enemy = enemy.instance()
#	inst_enemy.set_collision_layer_bit(1, true)
	if num_enemy < max_enemy:
		inst_enemy.set_name("enemy")
		inst_enemy.add_collision_exception_with(inst_enemy)
		
		var xPos = 0
		var yPos = 0
		var bottomRight = get_viewport().size.x
		var bottomLeft = get_viewport().size.y
		var xOffset = randi() % int(bottomRight)/2
		var yOffset = randi() % int(bottomLeft)/2
		var corner = randi() % 4 + 1
		while(xPos >= 0 && xPos <= bottomRight && yPos >= 0 && yPos <= bottomLeft):
			xPos = randi() % 200 + 100
			yPos = randi() % 200 + 100
			if corner == 1:
				xPos = xPos + xOffset * -1
				yPos = yPos + yOffset * -1
			elif corner == 2:
				xPos = xPos + bottomRight
				yPos = yPos + yOffset * -1
			elif corner == 3:
				xPos = xPos + xOffset * -1
				yPos = yPos + bottomLeft
			elif corner == 4:
				xPos = xPos + bottomRight
				yPos = yPos + bottomLeft
				
		inst_enemy.position = Vector2(xPos, yPos)
		inst_enemy.motion = Vector2(signVar*randi() % move_speed, signVar*randi() % move_speed)
		switch_sign()
		get_parent().add_child(inst_enemy)
		num_enemy += 1