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
	#if Input.is_action_pressed("W") or Input.is_action_pressed("ui_up")
	if Input.is_action_pressed("A") or Input.is_action_pressed("ui_left"):
		rotation_degrees += 1
	elif Input.is_action_pressed("D") or Input.is_action_pressed("ui_right"):
		rotation_degrees += 1
