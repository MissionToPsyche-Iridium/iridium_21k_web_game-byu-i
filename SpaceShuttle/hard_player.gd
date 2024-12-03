extends Node2D
var difficulty
var ShipVelocity = Vector2()
var MaxSpeedYPositive = 2
var MaxSpeedYNegative = -1
var MaxSpeedXPositive = 2
var MaxSpeedXNegative = -2
var gravity = .03
var thrusterPower = .2
var accelerationLeft = .05 
var accelerationRight = .05 
var win = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if difficulty == "Hard":
		$RocketShip.hide()
		$Apollo.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ShipVelocity.y += gravity
	print(rotation_degrees)
	if Input.is_action_pressed("A") or Input.is_action_pressed("ui_left"):
		#turn lander left if its not more than 90% to the left
		if rotation_degrees >= -90:
			rotation_degrees -= 1
		#correct for decimal issues
		if rotation_degrees <= -90:
			rotation_degrees = -90 
	elif Input.is_action_pressed("D") or Input.is_action_pressed("ui_right"):
		#turn lander right if its not more than 90% to the right
		if rotation_degrees <= 90:
			rotation_degrees += 1
		#correct for decimal issues
		if rotation_degrees >= 90:
			rotation_degrees = 90 
	if Input.is_action_pressed("W") or Input.is_action_pressed("ui_up"):
			#if rocket is straight up
			if rotation_degrees == 0:
				ShipVelocity.y -= thrusterPower
			#if rocket is right leaning
			if rotation_degrees > 0:
				#acelerate it upward proportinal to how upward its facing
				ShipVelocity.y -= thrusterPower * (.9 - (rotation_degrees*.01))
				#acelerate it to the right proportinal to how right its facing
				ShipVelocity.x += thrusterPower * (rotation_degrees*.01)
			if rotation_degrees < 0:
				ShipVelocity.y -= thrusterPower * (.9 - (rotation_degrees*.01))
				ShipVelocity.x += thrusterPower * (rotation_degrees*.01)
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
	
		
	if position.y >= 650:
			destroy_rocket("crashLanded")
	elif win == true:
		ShipVelocity = 0
		#lander_win()

func destroy_rocket(type):
	#write signal before queue_free
	Signalbus.emit_signal("landed_failed",type)
	queue_free()

func landed_rocket():
	Signalbus.emit_signal("landed_complete")
	win = true
	#get_tree().paused = true
	pass

#func lander_win():
	#ShipVelocity = 0
	##ShipVelocity.y = 0
	#pass

func _on_area_2d_area_entered(area: Area2D):
	if area.get_name() == "lander_box":
		landed_rocket()
		print("landed")
	elif area.get_name() == "planet_area":
		pass
	elif area.get_name() == "Meteorite_Area":
		destroy_rocket("hitMeteor")
	else:
		destroy_rocket("crashLanded")
	pass # Replace with function body.
