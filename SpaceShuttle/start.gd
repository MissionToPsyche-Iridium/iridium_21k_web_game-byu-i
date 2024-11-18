extends Node2D
var player = preload("res://player.tscn")
var HPlayer = preload("res://hard_player.tscn")
var mouse = preload("res://mouse.tscn")
var pc
var ms
var rng = RandomNumberGenerator
var trivAnswer
var difficulty


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_difficulty_buttons()
	Signalbus.answer.connect(getTriviaAnswer)
	Signalbus.landed_complete.connect(landed)
	Signalbus.start.connect(start)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Play():
	pass

# Hides buttons and shows difficutly options.
func _on_start_button_pressed():
	hide_stc_buttons()
	show_diffculty_buttons()

# takes user through tutorial
func _on_tutorial_button_pressed():
	hide_stc_buttons()
	pass

# will display credits then return the user back to the start screen
func _on_credits_button_pressed():
	hide_stc_buttons()
	pass

# toggles the mute button to either mute or unmute.
func _on_music_button_pressed():
	pass # Replace with function body.

# toggles the audio effects button to either mute or unmute.
func _on_audio_button_pressed():
	pass # Replace with function body.

# will take the user to the trivia portion of the game on easy mode.
func _on_easy_button_pressed():
	hide_difficulty_buttons()
	difficulty = "Easy"
	$Trivia.difficulty = "Easy"
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	ms = mouse.instantiate()
	add_child(ms)
	$Trivia.getTriviaQuestion()
	show_planets()
	#tempLander("easy")

# will take the user to the trivia portion of the game on medium mode.
func _on_medium_button_pressed():
	hide_difficulty_buttons()
	difficulty = "Medium"
	$Trivia.difficulty = "Medium"
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	ms = mouse.instantiate()
	ms.setMedium()
	add_child(ms)
	$Trivia.getTriviaQuestion()
	show_planets()
	#tempLander()

# will take the user to the trivia portion of the game on hard mode.
func _on_hard_button_pressed():
	hide_difficulty_buttons()
	difficulty = "Hard"
	$Trivia.difficulty = "Hard"
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	ms = mouse.instantiate()
	add_child(ms)
	$Trivia.getTriviaQuestion()
	show_planets()
	#tempLander()


# shows Start, Tutorial and Credits Buttons.
func show_stc_buttons():
	$startButton.show()
	$tutorialButton.show()
	$creditsButton.show()

# hides Start, Tutorial and Credits Buttons.
func hide_stc_buttons():
	$startButton.hide()
	$tutorialButton.hide()
	$creditsButton.hide()

# shows Easy, Medium and Hard Buttons.
func show_diffculty_buttons():
	$easyButton.show()
	$mediumButton.show()
	$hardButton.show()

# hides Easy, Medium and Hard Buttons.
func hide_difficulty_buttons():
	$easyButton.hide()
	$mediumButton.hide()
	$hardButton.hide()

func show_planets():
	$planets.show()

func hide_planets():
	$planets.hide()

func getTriviaAnswer(ans):
	trivAnswer = ans

# spawns the lander in the top middle of the screen
func tempLander(difficulty):
	pc = player.instantiate()
	pc.position = Vector2(600,20)
	#add_child(pc)

func landed():
	#display button
	$to_next.show()
	$winner_label.show()
	pass

func start(planet):
	$Surface.create_ground(difficulty)
	$Surface.show()
	$planets.hide()
	remove_child(ms)
	ms = null
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

#func difficulty():
#	$easy
#	$med
#	$hard


func _on_to_next_pressed():
	$to_next.hide()
	$winner_label.hide()
	pass # Replace with function body.
