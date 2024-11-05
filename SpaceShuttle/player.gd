extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += .98
	if Input.is_action_pressed("W"):
		position.y -= 4
	if Input.is_action_pressed("A"):
		position.x -= 2
	elif Input.is_action_pressed("D"):
		position.x += 2
	if position.y >= 560:
		destroy_rocket()
	

func destroy_rocket():
	queue_free()
