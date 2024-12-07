extends Node2D
var y


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_up()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func move_up():
	for i in range(0,648):
		position.y = i
