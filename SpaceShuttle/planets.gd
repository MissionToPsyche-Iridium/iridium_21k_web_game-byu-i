extends Node2D
var hints = preload("res://hints.tscn")
var rng = RandomNumberGenerator.new()
var difficulty
var sector24
var sector33
var sector42
var sector51
var ls = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sector24 = $Spaces/Sector24/CollisionShape2D
	sector33 = $Spaces/Sector33/CollisionShape2D
	sector42 = $Spaces/Sector42/CollisionShape2D
	sector51 = $Spaces/Sector51/CollisionShape2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hide_planets_buttons():
	pass

func show_planets_buttons():
	pass

func createHints(Planet):
	makeHint("One",Planet)
	if difficulty == "Easy":
		makeHint("Two",Planet)

func makeHint(Et, Planet):
	var s = rng.randi_range(0,3)
	var sector
	match s:
		0:
			sector = sector24
		1:
			sector = sector33
		2: 
			sector = sector42
		3:
			sector = sector51
	var rect = sector.shape.get_rect()
	var yRMx = sector.position.y + (rect.size.y/2)
	var yRMn = sector.position.y - (rect.size.y/2)
	var xRMx = sector.position.x + (rect.size.x/2)
	var xRMn = sector.position.x - (rect.size.x/2)
	var key = getKey(Planet,Et)
	var x = rng.randi_range(xRMn, xRMx)
	var y = rng.randi_range(yRMn, yRMx)
	
	var twinkle = hints.instantiate()
	twinkle.key = key
	add_child(twinkle)
	twinkle.position = Vector2(x,y)
	ls.append(twinkle)

func destroyHints():
	for i in ls:
		i.queue_free()
	ls = []

func getKey(planet,Et):
	var key = "H"
	match planet:
			"Mercury":
				key += "Me"
			"Venus":
				key += "V"
			"Earth":
				key += "E"
			"Mars":
				key += "Ma"
			"Jupiter":
				key += "J"
			"Saturn":
				key += "S"
			"Uranus":
				key += "U"
			"Neptune":
				key += "N"
			"Pluto":
				key += "Pl"
			"16 Psyche":
				key += "Ps"
	
	match difficulty:
		"Easy":
			match Et:
				"One":
					key += "1"
				"Two":
					key += "2"
		"Medium":
			key += "3"
		"Hard":
			key += "4"
	return key
