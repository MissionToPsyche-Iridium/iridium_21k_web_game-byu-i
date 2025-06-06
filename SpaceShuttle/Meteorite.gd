extends Node2D

var speed = Vector2()

func _ready():
	set_physics_process(true)
	position.x = randf() * get_viewport().size.x
	position.y = -30
	speed.x = randf_range(-150, 150)
	speed.y = randf_range(100, 200)

func _physics_process(delta):
	position += speed * delta
	if position.y > get_viewport().size.y or position.x < -30 or position.x > get_viewport().size.x:
		Signalbus.emit_signal("remove_meteor", get_instance_id())
		queue_free()
