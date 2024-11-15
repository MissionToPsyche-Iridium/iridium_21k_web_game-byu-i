extends Node2D
var difficulty

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if difficulty == "Medium":
		$Apollo.hide()
	elif difficulty == "Hard":
		$RocketShip.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
