extends Node2D
var sets = ["Alpha", "Beta", "Delta", "Gamma"]
var rng = RandomNumberGenerator.new()
var mouse_over = false
var key

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var z = rng.randi_range(0,3)
	var animSet = sets[z]
	$Area2D.key = key
	$AnimatedSprite2D.play(animSet)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int):
	if mouse_over == true and event.is_action_pressed("clickPlanet"):
		Signalbus.emit_signal("hint", key)


func _on_area_2d_mouse_entered() -> void:
	$Area2D.active = true
	Signalbus.emit_signal("deactivate")


func _on_area_2d_mouse_exited() -> void:
	mouse_over = false
	Signalbus.emit_signal("activate")
