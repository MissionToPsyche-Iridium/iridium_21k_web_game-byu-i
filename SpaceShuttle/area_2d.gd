extends Area2D
var active = false
var key

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int):
	if event.is_action_pressed("clickPlanet") and active == true:
		Signalbus.emit_signal("hint", key)