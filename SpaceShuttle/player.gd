extends Node2D
var ShipVelocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# makes the lander constantly move down at a constant speed
	ShipVelocity.y += .02
	if Input.is_action_pressed("W") or Input.is_action_pressed("ui_up"):
		ShipVelocity.y -= .1
	if Input.is_action_pressed("A") or Input.is_action_pressed("ui_left"):
		ShipVelocity.x -= .05
	elif Input.is_action_pressed("D") or Input.is_action_pressed("ui_right"):
		ShipVelocity.x += .05
	if ShipVelocity.y > 2:
		ShipVelocity.y = 2
	if ShipVelocity.y < -1:
		ShipVelocity.y = -1
	if ShipVelocity.x> 2:
		ShipVelocity.x= 2
	if ShipVelocity.x< -2:
		ShipVelocity.x= -2
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
	
	

func destroy_rocket():
	queue_free()
