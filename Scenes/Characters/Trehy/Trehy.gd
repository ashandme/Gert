extends KinematicBody2D
onready var Player = get_tree().get_nodes_in_group("Player")[0]
var Speed = 40
var Gravity = 9
var Direcction = -1
var Movement = Vector2()
const Floor = Vector2(0, -1)
var jump = -250
var heart = 5
var canMove = 0
var on_ground = false
var AttackPlayer = false
func _ready():
	$AnimatedSprite.play()
	$Look.add_exception(get_node("DanguerZone"))
func _physics_process(delta):
	if heart > 0:
		if AttackPlayer == true:
			Speed = 60
			if on_ground == true:
				if Player.position.x < position.x :
					Direcction = -1
					$Fall.position.x = -7
				if Player.position.x > position.x :
					Direcction = 1
					$Fall.position.x = 7
		if Player.get("is_dead") == true:
			AttackPlayer = false
		if is_on_floor():
			on_ground = true
		else:
			on_ground = false
		if is_on_wall():
			ChangePos()
		if Direcction == -1:
			$AnimatedSprite.set_flip_h(false)
		else:
			$AnimatedSprite.set_flip_h(true)
		if canMove == 2 or AttackPlayer == true:
			Movement.x = Speed * Direcction
			$AnimatedSprite.play("Run")
		else:
			Movement.x = 0
			$AnimatedSprite.play("Idle")
		if $Fall.is_colliding() == false:
			ChangePos()
		if $Look.is_colliding():
			var col = $Look.get_collider()
			if (col.is_in_group("Player")):
				AttackPlayer = true
	else:
		Movement.x = 0
		$AnimatedSprite.play("Dead")
		$DanguerZone/CollisionShape2D.set_disabled(true)
	Movement.y += Gravity
	Movement = move_and_slide(Movement, Floor)
	
func Random():
	canMove = randi()%2 +1
func _on_Timer_timeout():
	Random()
	$Timer.start()
func ChangePos():
	if !AttackPlayer:
		Direcction = Direcction * -1
		$Fall.position.x *= -1
		$Look.scale.x *= -1
		$Look.position.x *= -1
	else:
		if on_ground == true:
			Movement.y = jump
func Damage(var Damage):
	if heart > 0:
		heart -= Damage
		AttackPlayer = true
		if Player.position.x < position.x:
			$DeadParticles.set_emitting(true)
			$DeadParticles.process_material.gravity.x = 100
		if Player.position.x > position.x:
			$DeadParticles.set_emitting(true)
			$DeadParticles.process_material.gravity.x = -100



func _on_VisibilityNotifier2D_screen_entered():
	set_visible(true) 


func _on_VisibilityNotifier2D_screen_exited():
	set_visible(false)
