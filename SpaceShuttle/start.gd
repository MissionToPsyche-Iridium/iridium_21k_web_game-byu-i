extends Node2D

var HPlayer = preload("res://hard_player.tscn")
var player = preload("res://player.tscn")
var mouse = preload("res://mouse.tscn")
var star = preload("res://star.tscn")
var rng = RandomNumberGenerator.new()
var trivAnswer
var difficulty
var stars = []
var score = 0
var bonus
var WoL
var pc
var ms

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_difficulty_buttons()
	create_stars()
	Signalbus.answer.connect(getTriviaAnswer)
	Signalbus.landed_complete.connect(landed)
	Signalbus.landed_failed.connect(crashLanded)
	Signalbus.start.connect(start)

func _process(delta: float):
	for star in stars:
		star.position.x -= .5
		if star.position.x == -10:
			star.position.x = 1162

func update_score_display():
	$ScoreLabel.text = "Score: %d" % score
	#print(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func Play():
	pass

# Hides buttons and shows difficutly options
func _on_start_button_pressed():
	hide_stc_buttons()
	show_diffculty_buttons()

# takes user through tutorial
func _on_tutorial_button_pressed():
	hide_stc_buttons()
	$TutorialDifficulty.show()

# Will display credits then return the user back to the start screen
func _on_credits_button_pressed():
	hide_stc_buttons()
	$returnButton.show()
	$disclaimer.show()
	pass

func _on_return_button_pressed():
	show_stc_buttons()
	$returnButton.hide()
	$disclaimer.hide()
	pass

# Toggles the mute button to either mute or unmute
func _on_music_button_pressed():
	pass # Replace with function body.

# Toggles the audio effects button to either mute or unmute
func _on_audio_button_pressed():
	pass # Replace with function body.

# Will take the user to the trivia portion of the game on easy mode
func _on_easy_button_pressed():
	hide_difficulty_buttons()
	difficulty = "Easy"
	$planets.difficulty = "Easy"
	$Trivia.difficulty = "Easy"
	to_trivia()
	$ScoreLabel.show()
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	#ms = mouse.instantiate()
	#add_child(ms)
	#$Trivia.getTriviaQuestion()
	#show_planets()
	#tempLander("easy")

# Will take the user to the trivia portion of the game on medium mode
func _on_medium_button_pressed():
	hide_difficulty_buttons()
	difficulty = "Medium"
	$Trivia.difficulty = "Medium"
	$planets.difficulty = "Medium"
	to_trivia()
	$ScoreLabel.show()
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	#ms = mouse.instantiate()
	#add_child(ms)
	#$Trivia.getTriviaQuestion()
	#show_planets()
	#tempLander()

# Will take the user to the trivia portion of the game on hard mode
func _on_hard_button_pressed():
	hide_difficulty_buttons()
	difficulty = "Hard"
	$Trivia.difficulty = "Hard"
	$planets.difficulty = "Hard"
	to_trivia()
	$ScoreLabel.show()
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	#ms = mouse.instantiate()
	#add_child(ms)
	#$Trivia.getTriviaQuestion()
	#show_planets()
	#tempLander()

# Shows Start, Tutorial and Credits Buttons.
func show_stc_buttons():
	$startButton.show()
	$tutorialButton.show()
	$creditsButton.show()

# Hides Start, Tutorial and Credits Buttons.
func hide_stc_buttons():
	$startButton.hide()
	$tutorialButton.hide()
	$creditsButton.hide()

# Shows Easy, Medium and Hard Buttons.
func show_diffculty_buttons():
	$easyButton.show()
	$mediumButton.show()
	$hardButton.show()

# Hides Easy, Medium and Hard Buttons.
func hide_difficulty_buttons():
	$easyButton.hide()
	$mediumButton.hide()
	$hardButton.hide()

# Shows planets
func show_planets():
	$planets.show()
	Signalbus.emit_signal("activate")

# Hides planets
func hide_planets():
	$planets.hide()

# Gets the answer to the current trivia question
func getTriviaAnswer(ans, bone):
	trivAnswer = ans
	#print(trivAnswer)
	bonus = bone
	
# Spawns the lander in the top middle of the screen
func tempLander(diff):
	pc = player.instantiate()
	pc.position = Vector2(600,20)
	#add_child(pc)

# If the lander is landed
func landed():
	#display button
	$to_next.show()
	$winner_label.show()
	WoL = "Win"
	$Surface.Player_landed()
	
	match difficulty:
		"Easy":
			score +=1
		"Medium":
			score +=2
		"Hard":
			score +=3
	
	update_score_display()
	
# If the lander crash landed	
func crashLanded(type):
	#display button
	$to_next.show()
	if type == "hitMeteor":
		$crash_label.text = "Oh No! You got hit by a meteor!\nTry again?"
	elif type == "crashLanded":
		$crash_label.text = "Oh No! You crash landed on the planet!\nTry again?"
	elif type == "landedSideways":
		$crash_label.text = "Oh No! Your ship crashed because it was too tilted!\nTry again?"
	elif type == "hardHit":
		$crash_label.text = "Oh No! Your ship hit the landing pad too hard!\nTry again?"
	$crash_label.show()
	WoL = "Lose"
	
	match difficulty:
		"Easy":
			pass
		"Medium":
			score -= 1
		"Hard":
			score -= 2
	
	update_score_display()

func start(planet):
	#print(planet)
	Signalbus.emit_signal("deactivate")
	var correct
	var correctAnswer = ""
	
	$planets.destroyHints()
	$Trivia._on_button_pressed()
	
	# Hide the trivia question when starting
	$Trivia.hide()

	# Determine whether or not the answer is correct
	# Is it a bonus question?
	if (bonus):
		# Makes the correctAnswer variable equal the list
		for answer in trivAnswer:
			#print (answer)
			correctAnswer = correctAnswer + answer
			
			# Adds a comma to all entries except the last one
			if ((trivAnswer.size() - 1) > trivAnswer.find(answer)):
				correctAnswer +=  ", or "
		
		# Check the answer
		if (planet in trivAnswer):
			# Correct answer
			correct = true
			# Change the label
			$crash_label.text = "Congratulations!  You got the correct answer on a bonus question!"
			trivAnswer = planet
		else:
			# Incorrect answer
			correct = false
			# Change the label
			$crash_label.text = "Sorry, that answer was incorrect.  The correct answer was either " + correctAnswer + "."
			$crash_label.text += "\nAfter a noticing you were at the wrong planet, you turn around and go to the nearest correct planet."
			
			#set trivAnswer to the nearest correct answer
			#Variable set up
			var planetOrder = ["Mercury", "Venus", "Earth", "Mars", "Psyche", "Jupiter", "Saturn", "Uranus", "Neptune", "Pluto"]
			var pd2s = [.39, .72, 1, 1.52, 2.90, 5.20, 9.54, 19.22, 30.06, 39.50]
			var iPlanetInd = planetOrder.find(planet)
			var cPlanetInd = []
			var PDs = [] #P.Ds = Planetary Distances
			var iPD = pd2s[iPlanetInd]
			var sPD = 100 # s.P.D = smallest Planetary Distance
			
			#The process starts with finding each of the correct planet's index number in planetOrder
			for p in trivAnswer:
				cPlanetInd.append(planetOrder.find(p))
			
			#Next we find the related number in pd2s. Find the distance between the planet clicked and
			#the correct planets. Then put it into P.Ds
			for p in cPlanetInd:
				var cPD = pd2s[p]
				var distance = iPD - cPD
				if distance < 0:
					distance *= -1
				PDs.append(distance)
			
			#Now that we have the distances, we look for the smallest Planetary Distance (s.P.D.).
			for pd in PDs:
				if pd < sPD:
					sPD = pd
			
			#finds the s.P.D's index number and it should be the same index as the planet closest to 
			#the wrong planet that was clicked
			var fInd = PDs.find(sPD)
			var nCP = trivAnswer[fInd] #nearest Correct Planet
			
			#wrap it up by making trivAnswer equal just the n.C.P
			trivAnswer = nCP
			
	# If it is not a bonus question
	else:
		if planet == trivAnswer:
			# Correct answer
			correct = true
			# Change the label
			$crash_label.text = "Congratulations!  You got the correct answer!"
		else:
			# Incorrect answer
			correct = false
			# Change the label
			$crash_label.position.y -= 50
			$crash_label.text = "Sorry, that answer was incorrect.  The correct answer was " + trivAnswer + "."
			$crash_label.text += "\nAfter a noticing you were at the wrong planet, you turn around and reach " + trivAnswer + "."
	
	# Calculate points based on correct or incorrect answers
	# Is it a bonus question?
	if (bonus):
		# Correct answer
		if (correct):
			# Give points based on the difficulty
			match difficulty:
				"Easy":
					score += 2
				"Medium":
					score += 3
				"Hard":
					score += 5
		# Incorrect answer
		else:
			# No penalty for bonus questions
			pass		
	# If it is not a bonus question
	else:
		# Correct answer
		if (correct):
			# Give points based on the difficulty
			match difficulty:
				"Easy":
					score += 1
				"Medium":
					score += 2
				"Hard":
					score += 3
		# Incorrect answer
		else:
			# Lose points based on the difficulty
			match difficulty:
				"Easy":
					# No penalty on easy mode
					pass
				"Medium":
					score -= 1
				"Hard":
					score -= 2		
	
	# Update the scores calculated previously
	update_score_display()
	
	# Button to move to the next thing 
	$StartLander.show()
	
	# Show the label
	$crash_label.show()
	$crash_label.position.y -= 50
	
func playLander():
	$StartLander.hide()
	
	$crash_label.hide()
	$crash_label.position.y = 237
	
	# Make the ground of the planet and show it
	$Surface.create_ground(difficulty, trivAnswer)
	$Surface.show()
	
	# Hide the planets
	$planets.hide()
	
	remove_child(ms)
	ms = null
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
#func difficulty():
#	$easy
#	$med
#	$hard

func to_trivia():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	ms = mouse.instantiate()
	add_child(ms)
	ms.z_index = 1
	
	match difficulty:
		"Easy":
			# Default difficulty 
			pass
		"Medium":
			ms.setMedium()
		"Hard":
			ms.setHard()

	$Trivia.getTriviaQuestion()
	$Trivia.show()
	if (bonus):
		for i in trivAnswer:
			$planets.createHints(i)
	else:
		$planets.createHints(trivAnswer)
	show_planets()

func _on_to_next_pressed():
	$to_next.hide()
	$winner_label.hide()
	$crash_label.hide()
	$Surface.clear_level(WoL)
	$Trivia.show()
	to_trivia()

func create_stars():
	var x
	var y
	var z = 100
	#var minX = 376
	#var minY = 50
	#var maxX = 776
	#var maxY = 150
	while z != 0:
		z -= 1
		var celeb = star.instantiate()
		x = rng.randi_range(-10,1162)
		y = rng.randi_range(50,600)
		#while (x > minX) and (x < maxX) and (y > minY) and (y < maxY):
			#x = rng.randi_range(50,1100)
			#y = rng.randi_range(50,600)
		celeb.position = Vector2(x,y)
		#print("(" + str(x) + ", " + str(y) + ")")
		$starset.add_child(celeb)
		stars.append(celeb)
	#print("done")

func destroy_stars():
	for i in stars:
		$starset.remove_child(i)
		i.queue_free()

#func _on_to_planets_pressed():
	# Hide the button itself
#	$to_planets.hide()
	
	

# Going through the tutorial pages
func _on_to_next_1_pressed():
	$TutorialDifficulty.hide()
	$TutorialTriviaHint.show()
# Going through the tutorial pages
func _on_to_next_2_pressed():
	$TutorialTriviaHint.hide()
	$TutorialCorrect.show()
# Going through the tutorial pages
func _on_to_next_3_pressed():
	$TutorialCorrect.hide()
	$TutorialLander.show()
# Going through the tutorial pages
func _on_to_next_4_pressed():
	show_stc_buttons()
	$TutorialLander.hide()
