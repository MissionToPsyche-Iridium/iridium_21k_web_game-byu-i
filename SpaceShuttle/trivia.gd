extends Control

var file_path = "res://Trivia.json"
var triv
var difficulty
var rng = RandomNumberGenerator.new()
var prevQ = []
var question
var answer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	read_json()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Reads the file specified (Trivia)
func read_json():
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		var content = file.get_as_text()
		var json = JSON.new()
		triv = json.parse_string(content)

func getTriviaQuestion():
	var key = "T"
	
	if difficulty == "Easy":
		key += "E"
	elif difficulty == "Medium":
		key += "M"
	elif difficulty == "Hard":
		key += "H"
	
	key += "Q"
	
	var questionNumber = rng.randi_range(0,60)
	
	# Check to make sure no questions is repeated twice
	while(questionNumber in prevQ == true):
		questionNumber = rng.randi_range(0,60)
	
	# Add the previous question number to the list.  Make sure to add a way to delete, so that they
	prevQ.append(questionNumber)
	
	if questionNumber < 10:
		key += "00" + str(questionNumber)
	else:
		key += "0" + str(questionNumber)
	
	question = triv[key]
	key[2] = "A"
	answer = triv[key]
	$Label.text = question
