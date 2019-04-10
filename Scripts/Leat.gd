extends KinematicBody2D
onready var Player = get_tree().get_nodes_in_group("Player")[0]
const Laser = preload("res://Scenes/Objets/Laser.tscn")
var Movement = Vector2()
var Speed = 40
const Floor = Vector2(0,-1)
var Heart = 5
var AttackPlayer = false 
var Direction = 1
var on_ground = false
var Wall = false
var canMove = 0
var Gravity = 15
var Jump = -350
func _ready():
	$Look.add_exception(get_node("DanguerZone"))
	$Random.start()
func _physics_process(delta):
	if Heart > 0:
		if canMove == 2:
			Movement.x = Speed * Direction
			if Wall:
				Change_X()
		else:
			Movement.x = 0
		if $Look.is_colliding():
			var col = $Look.get_collider()
			if (col.is_in_group("Player")):
				AttackPlayer = true
		#if attakc player
		if AttackPlayer == true:
			if Player.position.x < position.x:
				Direction = -1
				$Fall.position.x = -6
			if Player.position.x > position.x:
				Direction = 1
				$Fall.position.x = 6
		#ANIM
		if Direction == -1:
			$AnimatedSprite.set_flip_h(true)
		else:
			$AnimatedSprite.set_flip_h(false)
		if Movement.x == 0:
			$AnimatedSprite.play("Idle")
		else:
			$AnimatedSprite.play("Run")
		if Movement.y < 0:
			$AnimatedSprite.play("Jump")
		if Movement.y > 10:
			$AnimatedSprite.play("Falling")
	#end if Heart > 0
	if is_on_wall():
		Wall = true
	else:
		Wall = false
	Movement.y += Gravity
	Movement = move_and_slide(Movement, Floor)
func Change_X():
	if AttackPlayer == false:
		Direction = Direction * -1
		$Fall.position.x *= -1
		$Look.scale.x *= -1
		$Look.position.x *= -1
	else:
		if on_ground:
			Movement.y = Jump
#RAMDOM__________________________________________
func Random():
	canMove = randi()%2 +1
func _on_Random_timeout():
	Random()
	$Random.start()

func _on_VisibilityNotifier2D_screen_entered():
	set_visible(true)

func _on_VisibilityNotifier2D_screen_exited():
	set_visible(false)
