extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += .98
	if Input.is_action_pressed("W") or Input.is_action_pressed("ui_up"):
		position.y -= 4
	if Input.is_action_pressed("A") or Input.is_action_pressed("ui_left"):
		position.x -= 2
	elif Input.is_action_pressed("D") or Input.is_action_pressed("ui_right"):
		position.x += 2
	if position.y >= 560:
		destroy_rocket()
	

func destroy_rocket():
	queue_free()
