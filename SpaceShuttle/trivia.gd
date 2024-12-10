extends Node2D

var rng = RandomNumberGenerator.new()
var file_path = "res://Trivia.json"
var hint_path = "res://hints.json"
var prevBQ = []
var prevQ = []
var qCount = 0
var prevBQemptied
var prevQemptied
var difficulty
var question
var answer
var hints
var triv

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	read_json()
	read_hints()
	Signalbus.hint.connect(hint)
	#test_json()

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta: float) -> void:
	# Empties the list of questions when it reaches 60
	if prevQ.size() == 60:
		# Using a temp variable to set the first slot of the question list to the last question, before emptying it
		prevQemptied = prevQ[60]
		emptyPrevQ()
		prevBQ.append(prevQemptied)
			
	# Empties the list of bonus questions when it reaches 15	
	if prevBQ.size() == 15:
		# Using a temp variable to set the first slot of the question list to the last question, before emptying it
		prevBQemptied = prevBQ[15]
		emptyPrevBQ()
		prevBQ.append(prevBQemptied)

# Reads the file specified (Trivia)
func read_json():
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		var content = file.get_as_text()
		var json = JSON.new()
		triv = json.parse_string(content)

func read_hints():
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(hint_path, FileAccess.READ)
		var content = file.get_as_text()
		var json = JSON.new()
		hints = json.parse_string(content)

# Reads the JSON file to get a trivia question and its answer
func getTriviaQuestion():
	var key
	var qNum
	var bonus = false
	# Checks to do a bonus question every tenth question
	if qCount == 10:
		qCount = 0
		key = "TBQ"
		bonus = true
		qNum = rng.randi_range(1,15)
		
		# Make sure the bonus question is not repeated
		while((qNum in prevBQ) == true):
			qNum = rng.randi_range(1,15)
		
		# Adds the bonus question to the bonus question list	
		prevBQ.append(qNum)
	
	else:
		qCount += 1
		# Parsing info for establishing questions
		key = "T"
		match difficulty: 
			"Easy":
				key += "E"
			"Medium":
				key += "M"
			"Hard":
				key += "H"
		key += "Q"
		qNum = rng.randi_range(1,60)
		
		# Check to make sure no questions is repeated twice
		while((qNum in prevQ) == true):
			qNum = rng.randi_range(1,60)
		
		# Add the previous question number to the list
		prevQ.append(qNum)
	
	# Parsing info for establishing questions
	if qNum < 10:
		key += "00" + str(qNum)
	
	else:
		key += "0" + str(qNum)
	
	# Parsing info for establishing answers
	question = triv[key]
	key[2] = "A"
	answer = triv[key]
	$TextureRect/Label.text = question
	Signalbus.emit_signal("answer",answer, bonus)

# Sets the list of questions to an empty list
func emptyPrevQ():
	prevQ = []

# Sets the list of bonus questions to an empty list	
func emptyPrevBQ():
	prevBQ = []	

# Tests to see if all the questions/answers are numbered correctly
func test_json():
	var num = 1
	var diff = "E"
	var QoA = "Q"
	var k
	while k != "THA060":
		if num <= 9:
			k = "T" + diff + QoA + "00" + str(num)
		else: 
			k = "T" + diff + QoA + "0" + str(num)
		triv[k]
		if num == 60:
			if QoA == "A":
				if diff == "M":
					diff = "H"
					QoA = "Q"
					num = 1
				elif diff == "E":
					diff = "M"
					QoA = "Q"
					num = 1
			else:
				QoA = "A"
				num = 1
		else:
			num += 1

func hint(key):
	$TextureRect/Label.text = hints[key]
	$TextureRect/Button.show()


func _on_button_pressed() -> void:
	$TextureRect/Label.text = question
	$TextureRect/Button.hide()
