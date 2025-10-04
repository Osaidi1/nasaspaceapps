extends CharacterBody2D

@onready var animated: AnimatedSprite2D = $AnimatedSprite2D

var velo_dir: Vector2
var velo: Vector2
const SPEED = 100
var is_moving = false

func _physics_process(_delta: float) -> void:
	#Get Input
	velo = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	if velo.x != 0 or velo.y != 0:

		velo_dir = velo
	if velo.length() > 0:
		velo = velo.normalized()
	#Set Velocity
	velocity.x = velo.x * SPEED
	velocity.y = velo.y * SPEED
	
	#Set Moving var
	if velo.x != 0 or velo.y != 0:
		is_moving = true
	else:
		is_moving = false
	
	#Anims
	anims()
	
	#Move
	move_and_slide()
	
	#End Velocity
	velo.x = 0
	velo.y = 0

func anims():
	if is_moving:
		if Input.is_action_pressed("left") or Input.is_action_pressed("right") or Input.is_action_pressed("down") or Input.is_action_pressed("up"):
			if velo_dir.x > 0:
				if velo_dir.y > 0:
					animated.play("dr-walk")
				elif velo_dir.y < 0:
					animated.play("ur-walk")
				else:
					animated.play("r-walk")
			#Left
			elif velo_dir.x < 0:
				if velo_dir.y > 0:
					animated.play("dl-walk")
				elif velo_dir.y < 0:
					animated.play("ul-walk")
				else:
					animated.play("l-walk")
			elif velo_dir.y < 0:
				animated.play("u-walk")
			elif velo_dir.y > 0:
				animated.play("d-walk")
	else:
		#Right
		if velo_dir.x > 0:
			if velo_dir.y > 0:
				animated.play("dr-idle")
			elif velo_dir.y < 0:
				animated.play("ur-idle")
			else:
				animated.play("r-idle")
		#Left
		elif velo_dir.x < 0:
			if velo_dir.y > 0:
				animated.play("dl-idle")
			elif velo_dir.y < 0:
				animated.play("ul-idle")
			else:
				animated.play("l-idle")
		elif velo_dir.y < 0:
			animated.play("u-idle")
		elif velo_dir.y > 0:
			animated.play("d-idle")
