extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += .098

func _unhandled_input(event):
	if event.is_action_pressed("W"):
		position.y -= 2
	elif event.is_action_pressed("A"):
		position.x -= 2
	elif event.is_action_pressed("D"):
		position.x += 2
