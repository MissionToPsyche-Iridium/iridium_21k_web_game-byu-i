extends Node2D
var player = preload("res://player.tscn")
var pc


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$easyButton.hide()
	$mediumButton.hide()
	$hardButton.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Play():
	pass

func _on_startButton_pressed():
	hide_stc_buttons()
	$easyButton.show()
	$mediumButton.show()
	$hardButton.show()

func _on_tutorial_button_pressed():
	hide_stc_buttons()
	#pass

func _on_credits_button_pressed():
	hide_stc_buttons()
	#pass

func _on_music_button_pressed():
	pass # Replace with function body.

func _on_audio_button_pressed():
	pass # Replace with function body.

func _on_easy_button_pressed():
	hide_difficulty_buttons()
	pc = player.instantiate()
	pc.position = Vector2(20,20)
	add_child(pc)

func _on_medium_button_pressed():
	hide_difficulty_buttons()
	pc = player.instantiate()
	pc.position = Vector2(20,20)
	add_child(pc)

func _on_hard_button_pressed():
	hide_difficulty_buttons()
	pc = player.instantiate()
	pc.position = Vector2(20,20)
	add_child(pc)

func hide_stc_buttons():
	$startButton.hide()
	$tutorialButton.hide()
	$creditsButton.hide()

func hide_difficulty_buttons():
	$easyButton.hide()
	$mediumButton.hide()
	$hardButton.hide()

#func difficulty():
#	$easy
#	$med
#	$hard
