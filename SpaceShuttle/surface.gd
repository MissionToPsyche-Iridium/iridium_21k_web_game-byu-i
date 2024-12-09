extends Node2D
var Hplayer = preload("res://hard_player.tscn")
var test = preload("res://placement_test.tscn")
var meteor = preload("res://Meteorite.tscn")
var ground2 = preload("res://ground_2.tscn")
var pad = preload("res://landing_pad.tscn")
var ground = preload("res://ground.tscn")
var player = preload("res://player.tscn")
var rng = RandomNumberGenerator.new()
var meteorites = []
var testers = []
var planet = []
var grC = []
var lp
var p

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signalbus.remove_meteor.connect(remove_meteorite)

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

@warning_ignore("unused_parameter")
func create_ground(diff, pl):
	#var g = ground.instantiate()
	#rng between 500-600, create 13 vectors (x,y)
	#g.position #= 1st vector
	setLandingPad(diff)
	var z = 13
	var xb = -100
	var points = []
	var lpPos = Vector2(lp.position.x-38,lp.position.y)
	var lpEndPos = Vector2(lp.position.x+38,lp.position.y)
	var blp = Vector2(0,0)
	var alp = Vector2(10000,10000)
	while z > 0:
		var x = rng.randi_range(xb,xb+100)
		var y #= rng.randi_range(500,600)
		
		match diff:
			"Easy":
				y = rng.randi_range(500,600)
			"Medium":
				y = rng.randi_range(300,600)
			"Hard":
				y = rng.randi_range(300,600)
				
		#var tester = test.instantiate()
		#tester.position = Vector2(x,y)
		#print(tester.position)
		#add_child(tester)
		#testers.append(tester)
		if x > lpPos.x and x < lpEndPos.x:
			x = lpEndPos.x
			y = lpEndPos.y
		if x == lpPos.x:
			x = lpPos.x
			y = lpPos.y
		points.append(Vector2(x,y))
		xb += 100
		z -= 1
		if x < lpPos.x and x > blp.x:
			blp = Vector2(x,y)
		if x > lpEndPos.x and x < alp.x:
			alp = Vector2(x,y)
	#-50, 50, 150, 250, 350, 450, 550, 650, 750,
	if (lpPos in points) == false:
		#print(points)
		var i = points.find(blp)
		points.insert(i+1,lpPos)
		#print(points)
	if (lpEndPos in points) == false:
		#print(points)
		var i = points.find(alp)
		points.insert(i,lpEndPos)
		#print(points)
	var c = 1
	@warning_ignore("unused_variable")
	var pAng
	for pos in points:
		#if pos != lpPos:
		var g = ground.instantiate()
		g.position = pos
		add_child(g)
		planet.append(g)
		var n = points[c]
		var gPos = g.position
		@warning_ignore("confusable_local_declaration")
		var ang = gPos.angle_to_point(n)
		g.rotation = ang
		var distance = gPos.distance_to(n)
		g.scale.x = distance/100
		pAng = ang
		if c != points.size() - 1:
			c += 1
	
	var Xs = []
	for i in planet:
		Xs.append(i.position.x)
	
	var ang
	var stp
	var enp
	
	@warning_ignore("unused_variable")
	var x1 = Xs[0]
	@warning_ignore("unused_variable")
	var x2 = Xs[12]
	
	# testing code
	#var test = []
	#for p in planet:
		#test.append(p.position.x)
	#print(Xs)
	#print(test)
	var adj
	var opp
	var hyp
	for p in planet:
		var np 
		if planet.find(p)+1 != planet.size():
			np = planet[planet.find(p)+1]
		else:
			np = p
		ang = p.rotation
		stp = p.position
		enp = np.position
		var sx = stp.x
		var ex = enp.x
		var r = ex - sx
		var memory
		var test = []
		var test2 = []
		for i in range(0,r):
			if ang != 0:
				adj = i
				hyp = adj / cos(ang)
				opp = sin(ang) * hyp
			else:
				opp = 0
			var y = stp.y + opp
			var gC = ground2.instantiate()
			test.append(Vector2(i+sx,y))
			test2.append(opp)
			gC.position = Vector2(i+sx,y)
			add_child(gC)
			grC.append(gC)
			#if memory == null and y != p.y:
				#pass
	
	$MeteoriteTimer.start()	
	
	match diff:
		"Easy":
			p = player.instantiate()
		"Medium":
			p = Hplayer.instantiate()
		"Hard":
			p = Hplayer.instantiate()
			p.difficulty = "Hard"
			
	add_child(p)
	p.position = Vector2(rng.randi_range(100,1000),rng.randi_range(100,150))

func setLandingPad(diff):
	var x = rng.randi_range(100,1052)
	var y #= rng.randi_range(500,600)
	
	match diff:
		"Easy":
			y = rng.randi_range(500,600)
		"Medium":
			y = rng.randi_range(400,640)
		"Hard":
			y = rng.randi_range(400,640)
			
	lp = pad.instantiate()
	lp.position = Vector2(x,y)
	$LandPad.add_child(lp)
	
	#var gr = ground2.instantiate()
	#gr.position = Vector2(x,y)
	#planet.append(gr)

func Mercury():
	pass
	#Change ground color to orange

func Mars():
	pass
	#change ground color to Red

func Earth():
	pass
	#change ground color to green

func _on_meteorite_timer_timeout():
	#print("Spawning meteorite1") # Debug
	var meteorite = meteor.instantiate()
	$Meteors.add_child(meteorite)
	meteorites.append(meteorite)

func remove_meteorite(IID):
	var ind
	for i in meteorites:
		if i.get_instance_id() == IID:
			ind = meteorites.find(i)
			meteorites.remove_at(ind)

func Player_landed():
	p.position = lp.position + Vector2(0,-21)

func clear_level(WoL):
	$MeteoriteTimer.stop()
	for i in meteorites:
		i.queue_free()
	for i in testers:
		i.queue_free()
	for i in planet:
		i.queue_free()
	for i in grC:
		i.queue_free()
	meteorites = []
	testers = []
	planet = []
	grC = []
	lp.queue_free()
	if WoL == "Win":
		p.queue_free()

func stars():
	var x = rng.randi_range(50,1100)
	var y = rng.randi_range(50,600)
	var minXB 
	var maxXB
	var minYB
	var maxYB
	while x >= minXB & x <= maxXB & y >= minYB & y <= maxYB:
		x = rng.randi_range(50,1100)
		y = rng.randi_range(50,600)
