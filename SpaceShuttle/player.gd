extends Node2D
var ShipVelocity = Vector2()
var MaxSpeedYPositive = 1
var MaxSpeedYNegative = -1
var MaxSpeedXPositive = 2
var MaxSpeedXNegative = -2
var gravity = .02
var thrusterPower = .06
var accelerationLeft = .05 
var accelerationRight = .05 
var win = false
var canBeHit = true
var ignore = ["Sector24", "Sector33", "Sector42", "Sector51"]

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
		
		#if position.y >= 650:
			#destroy_rocket("crashLanded")
	elif win == true:
		ShipVelocity = 0
		#lander_win()

func destroy_rocket(type):
	#write signal before queue_free
	if win == false:
		Signalbus.emit_signal("landed_failed",type)
		queue_free()
	else:
		pass

func landed_rocket():
	Signalbus.emit_signal("landed_complete")
	win = true
	#get_tree().paused = true
	pass

#func lander_win():
	#ShipVelocity = 0
	##ShipVelocity.y = 0
	#pass

func _on_easy_area_2d_area_entered(area: Area2D):
	if area.get_name() == "lander_box":
		canBeHit = false
		landed_rocket()
		#print("landed")
	elif (area.get_name() in ignore):
		pass
	elif area.get_name() == "planet_area":
		pass
	elif area.get_name() == "Meteorite_Area":
		if canBeHit == true:
			destroy_rocket("hitMeteor")
		else:
			pass
	else:
		if canBeHit == true and area.get_name() != "lander_box":
			print("crashed")
			destroy_rocket("crashLanded")
		else:
			pass
	pass # Replace with function body.
