extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if event.is_action_pressed("Spacebar"):
		if $Label.visible == true:
			$Label.hide()
			$ColorRect.position = Vector2(100,300)
		elif $Label.visible == false:
			$Label.show()
			$ColorRect.position = Vector2(400,50)
