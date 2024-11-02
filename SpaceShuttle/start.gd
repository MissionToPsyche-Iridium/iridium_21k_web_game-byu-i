extends Node2D
var player = preload("res://player.tscn")
var pc
var rng = RandomNumberGenerator


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Play():
	pass

func _on_startButton_pressed():
	pc = player.instantiate()
	pc.position = Vector2(20,20)
	add_child(pc)
	hide_buttons()

func _on_tutorialButton_pressed():
	pass

func _on_creditsButton_pressed():
	pass

func _on_settingsButton_pressed():
	pass

func hide_buttons():
	$startButton.hide()
	$tutorialButton.hide()
	$creditsButton.hide()

#func difficulty():
#	$easy
#	$med
#	$hard
