extends Node2D
var ShipVelocity = Vector2()
var MaxSpeedYPositive = 2
var MaxSpeedYNegative = -1
var MaxSpeedXPositive = 2
var MaxSpeedXNegative = -2
var gravity = .03
var thrusterPower = .1
var accelerationLeft = .05 
var accelerationRight = .05 
var win = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func set_value(val):
	MaxSpeedYPositive = val

func _process(delta):
	# makes the lander constantly move down at a constant speed
	if win == false:
		ShipVelocity.y += gravity
		if Input.is_action_pressed("W") or Input.is_action_pressed("ui_up"):
			ShipVelocity.y -= thrusterPower
		if Input.is_action_pressed("A") or Input.is_action_pressed("ui_left"):
			ShipVelocity.x -= accelerationLeft
		elif Input.is_action_pressed("D") or Input.is_action_pressed("ui_right"):
			ShipVelocity.x += accelerationRight
		if ShipVelocity.y > MaxSpeedYPositive:
			ShipVelocity.y = MaxSpeedYPositive
		if ShipVelocity.y < MaxSpeedYNegative:
			ShipVelocity.y = MaxSpeedYNegative
		if ShipVelocity.x> MaxSpeedXPositive:
			ShipVelocity.x= MaxSpeedXPositive
		if ShipVelocity.x< MaxSpeedXNegative:
			ShipVelocity.x= MaxSpeedXNegative
		if ShipVelocity.x < 0 and position.x < 27:
			ShipVelocity.x = 0
		if ShipVelocity.x > 0 and position.x > 1124:
			ShipVelocity.x = 0
		if ShipVelocity.y < 0 and position.y <= 20:
			ShipVelocity.y = 0
		position.x += ShipVelocity.x 
		position.y += ShipVelocity.y
		
		if position.y >= 560:
			destroy_rocket()
	elif win == true:
		lander_win()

func destroy_rocket():
	#write signal before queue_free
	queue_free()

func landed_rocket():
	Signalbus.emit_signal("landed_complete")
	#get_tree().paused = true
	pass

func lander_win():
	pass
