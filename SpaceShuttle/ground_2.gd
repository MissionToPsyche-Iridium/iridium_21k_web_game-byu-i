extends Node2D
var z = false
var a = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale.y = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if a == false:
		position.y -= 1


func _on_ground_finder_area_entered(area: Area2D) -> void:
	if z == false and (area.get_name() == "Ground" or area.get_name() == "lander_box"):
		var aPos = area.global_position
		var gPos = position
		position.y = area.global_position.y + 100
		z = true
	elif z == true and (area.get_name() == "Ground" or area.get_name() == "lander_box"):
		a = true
