extends Node2D
var ground = preload("res://ground.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create_ground():
	var g = ground.instantiate()
	#rng between 500-600, create 13 vectors (x,y)
	g.position #= 1st vector

func Mercury():
	pass
	#Change ground color to orange

func Mars():
	pass
	#change ground color to Red

func Earth():
	pass
	#change ground color to green
