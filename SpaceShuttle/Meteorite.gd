extends ColorRect

var speed = Vector2()

func _ready():
	set_physics_process(true)
	position.x = randf() * get_viewport().size.x
	position.y = -30
	speed.x = randf_range(-200, 200)
	speed.y = randf_range(100, 300)

func _physics_process(delta):
	position += speed * delta
	if position.y > get_viewport().size.y or position.x < -30 or position.x > get_viewport().size.x:
		queue_free()
