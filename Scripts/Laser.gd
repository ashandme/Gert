extends Area2D
#x = 1 y -1, y = 2 y -2, xy^ = 3, -3, yx = 4, -4 v
var Direction
export var Speed = 60
var Movement = Vector2()
var DY = 0
var DX = 0
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
func DirectionXY(dir):
	Direction = dir
func _physics_process(delta):
	Movement.x = Speed * DX * delta
	Movement.x = Speed * DY * delta
	translate(Movement)
	if Direction == 1:
		$AnimatedSprite.play("LaserR")
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.rotation_degrees(0)
		DY = 0
		DX = 1
	if Direction == -1:
		$AnimatedSprite.play("LaserR")
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.rotation_degrees(0)
		DY = 0
		DX = -1
	if Direction == 2:
		$AnimatedSprite.play("LaserR")
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.rotation_degrees(90)
		DY = 1
		DX = 0
	if Direction == -2:
		$AnimatedSprite.play("LaserR")
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.rotation_degrees(270)
		DY = -1
		DX = 0
	if Direction == 3:
		$AnimatedSprite.play("LaserD")
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.rotation_degrees(270)
		DY = -1
		DX = 1
	if Direction == -3:
		$AnimatedSprite.play("LaserD")
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.rotation_degrees(180)
		DY = -1
		DX = -1
	if Direction == 4:
		$AnimatedSprite.play("LaserD")
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.rotation_degrees(0)
		DY = 1
		DX = 1
	if Direction == -4:
		$AnimatedSprite.play("LaserD")
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.rotation_degrees(0)
		DY = 1
		DX = -1