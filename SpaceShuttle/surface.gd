extends Node2D
var ground = preload("res://ground.tscn")
var test = preload("res://placement_test.tscn")
var pad = preload("res://landing_pad.tscn")
var rng = RandomNumberGenerator.new()
var lp


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create_ground(diff):
	#var g = ground.instantiate()
	#rng between 500-600, create 13 vectors (x,y)
	#g.position #= 1st vector
	setLandingPad(diff)
	var z = 12
	var xb = 0
	while z > 0:
		var x = rng.randi_range(xb,xb+100)
		var y
		if diff == "Easy":
			y = rng.randi_range(500,600)
		else:
			y = rng.randi_range(300,600)
		var tester = test.instantiate()
		tester.position = Vector2(x,y)
		print(tester.position)
		add_child(tester)
		xb += 100
		z -= 1

func setLandingPad(diff):
	var x = rng.randi_range(0,1100)
	var y
	if diff == "Easy":
		y = rng.randi_range(500,600)
	else:
		y = rng.randi_range(400,640)
	lp = pad.instantiate()
	lp.position = Vector2(x,y)
	add_child(lp)

func Mercury():
	pass
	#Change ground color to orange

func Mars():
	pass
	#change ground color to Red

func Earth():
	pass
	#change ground color to green
