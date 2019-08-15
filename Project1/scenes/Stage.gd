extends Node2D

var enemy = preload("res://scenes/Enemy.tscn")

var timer = null
var default_delay = 2
var can_spawn = true
var max_enemy = 5
var num_enemy = 0
var move_speed = 100

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

func spawn_enemy():
	var inst_enemy = enemy.instance()
	if inst_enemy.num_enemy < max_enemy:
		
		inst_enemy.set_name("enemy")
		inst_enemy.add_collision_exception_with(inst_enemy)
		inst_enemy.position = Vector2((randi() % 1000) + 32, (randi() % 500) + 32)
		inst_enemy.motion = Vector2(randi() % move_speed, randi() % move_speed)
		
		get_parent().add_child(inst_enemy)
		inst_enemy.num_enemy += 1