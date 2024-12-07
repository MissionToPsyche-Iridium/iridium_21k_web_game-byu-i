extends Node2D
var t1 = preload("res://Art/Alpha/Alpha1.png")
var t2 = preload("res://Art/Alpha/Alpha2.png")
var t3 = preload("res://Art/Alpha/Alpha3.png")
var t4 = preload("res://Art/Alpha/Alpha4.png")
var t5 = preload("res://Art/Beta/Beta1.png")
var t6 = preload("res://Art/Beta/Beta2.png")
var t7 = preload("res://Art/Beta/Beta3.png")
var t8 = preload("res://Art/Beta/Beta4.png")
var t9 = preload("res://Art/Delta/Gamma1.png")
var t10 = preload("res://Art/Delta/Gamma2.png")
var t11 = preload("res://Art/Delta/Gamma3.png")
var t12 = preload("res://Art/Delta/Gamma4.png")
var t13 = preload("res://Art/Gamma/Delta1.png")
var t14 = preload("res://Art/Gamma/Delta2.png")
var t15 = preload("res://Art/Gamma/Delta3.png")
var t16 = preload("res://Art/Gamma/Delta4.png")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var x = rng.randi_range(1,16)
	match x:
		1:
			$Sprite2D.set_texture(t1)
		2:
			$Sprite2D.set_texture(t2)
		3:
			$Sprite2D.set_texture(t3)
		4:
			$Sprite2D.set_texture(t4)
		5:
			$Sprite2D.set_texture(t5)
		6:
			$Sprite2D.set_texture(t6)
		7:
			$Sprite2D.set_texture(t7)
		8:
			$Sprite2D.set_texture(t8)
		9:
			$Sprite2D.set_texture(t9)
		10:
			$Sprite2D.set_texture(t10)
		11:
			$Sprite2D.set_texture(t11)
		12:
			$Sprite2D.set_texture(t12)
		13:
			$Sprite2D.set_texture(t13)
		14:
			$Sprite2D.set_texture(t14)
		15:
			$Sprite2D.set_texture(t15)
		16:
			$Sprite2D.set_texture(t16)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
