extends KinematicBody2D

onready var timer = $Timer

var gravityState = 1
var motion = Vector2()
var up = Vector2()
var spawnPoint

const SPEED = 1000
const JUMP = -1000

func _ready():
	spawnPoint = position

func _physics_process(delta):
	if gravityState == 1:
		up = Vector2(0, -1)
		motion.y += 50
		
		if Input.is_action_pressed("ui_left"):
			motion.x = -SPEED
		elif Input.is_action_pressed("ui_right"):
			motion.x = SPEED
		else:
			motion.x = 0
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = JUMP
				
	elif gravityState == 2:
		up = Vector2(-1, 0)
		motion.x += 50
		
		if Input.is_action_pressed("ui_down"):
			motion.y = SPEED
		elif Input.is_action_pressed("ui_up"):
			motion.y = -SPEED
		else:
			motion.y = 0
		if is_on_floor():
			if Input.is_action_just_pressed("ui_left"):
				motion.x = JUMP
	
	elif gravityState == 3:
		up = Vector2(0, 1)
		motion.y -= 50
		
		if Input.is_action_pressed("ui_left"):
			motion.x = -SPEED
		elif Input.is_action_pressed("ui_right"):
			motion.x = SPEED
		else:
			motion.x = 0
		if is_on_floor():
			if Input.is_action_just_pressed("ui_down"):
				motion.y = -JUMP
	
	elif gravityState == 4:
		up = Vector2(1, 0)
		motion.x -= 50
		
		if Input.is_action_pressed("ui_up"):
			motion.y = -SPEED
		elif Input.is_action_pressed("ui_down"):
			motion.y = SPEED
		else: 
			motion.y = 0
		if is_on_floor():
			if Input.is_action_just_pressed("ui_right"):
				motion.x = -JUMP
				
	motion = move_and_slide(motion, up)
	
	

func _on_Timer_timeout():
	if gravityState == 1:
		gravityState = 2
	elif gravityState == 2:
		gravityState = 3
	elif gravityState == 3:
		gravityState = 4
	elif gravityState == 4:
		gravityState = 1


func _on_Area2D_body_entered(body):
	position = spawnPoint
	gravityState = 1
	timer.set_wait_time(3)
