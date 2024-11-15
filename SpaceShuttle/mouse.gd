extends Node2D
var medium = preload("res://Art/Rocket Ship 1.0.png")
var hard
var difficulty
var lastPlace = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_global_mouse_position()
	if difficulty == "Med":
		if position.x - lastPlace.x > 0:
			$Sprite2D.rotation_degrees = 90
		elif position.x - lastPlace.x < 0:
			$Sprite2D.rotation_degrees = 270
	lastPlace = position

func setMedium():
	$Sprite2D.set_texture(medium)
	$Sprite2D.rotation_degrees = 90
	difficulty = "Med"

func setHard():
	pass
