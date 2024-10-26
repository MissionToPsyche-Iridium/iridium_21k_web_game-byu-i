extends Node2D
var rng = RandomNumberGenerator.new()
var RI
var dif

# Called when the node enters the scene tree for the first time.
func _ready():
	if dif == "Easy":
		RI = rng.randi_range(0,10)
	if dif == "Med":
		RI = rng.randi_range(11,20)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if event.is_action_pressed("Spacebar"):
		if $Label.visible == true:
			$Label.hide()
		elif $Label.visible == false:
			$Label.show()
