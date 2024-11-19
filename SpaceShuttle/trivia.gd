extends Node2D

var rng = RandomNumberGenerator.new()
var file_path = "res://Trivia.json"
var prevBQ = []
var prevQ = []
var difficulty
var question
var answer
var triv

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	read_json()
	#test_json()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if prevQ.size() == 60:
		emptyPrevQ()

# Reads the file specified (Trivia)
func read_json():
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		var content = file.get_as_text()
		var json = JSON.new()
		triv = json.parse_string(content)

func getTriviaQuestion():
	var key
	var qNum
	if (prevQ.size() != 0) && (prevQ.size() % 10) == 0:
		key = "TBQ"
		qNum = rng.randi_range(1,15)
		while((qNum in prevBQ) == true):
			qNum = rng.randi_range(1,15)
		prevBQ.append(qNum)
	else:
		key = "T"
		if difficulty == "Easy":
			key += "E"
		elif difficulty == "Medium":
			key += "M"
		elif difficulty == "Hard":
			key += "H"
		key += "Q"
		qNum = rng.randi_range(1,60)
		# Check to make sure no questions is repeated twice
		while((qNum in prevQ) == true):
			qNum = rng.randi_range(1,60)
		# Add the previous question number to the list.  Make sure to add a way to delete, so that they
		prevQ.append(qNum)
	if qNum < 10:
		key += "00" + str(qNum)
	else:
		key += "0" + str(qNum)
	question = triv[key]
	key[2] = "A"
	answer = triv[key]
	$Label.text = question
	Signalbus.emit_signal("answer",answer)

func emptyPrevQ():
	prevQ = []

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
	
