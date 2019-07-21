extends KinematicBody2D
var Movement = Vector2(); #vec2 get horizontal and Vertical value
var Gravity = 15;
var Jump = -300;
const FLOOR = Vector2(0 , -1);
var Speed = 70; 
var Direction = -1; #get direction for flip sprites
var OnG = false; #on Ground variable
var boolAttack = false
#other
#life
var Heart = 5;
func _physics_process(delta):
	if Heart > 0:
		if Input.is_action_pressed("Right_M"):
			Movement.x = Speed;
		elif Input.is_action_pressed("Left_M"):
			Movement.x = -Speed;
		else:
			Movement.x = 0
		if Input.is_action_just_pressed("Jump"):
			if OnG == true:
				Movement.y = Jump
		if Input.is_action_just_pressed("Attack_X"):
			attack()
		#Get
		if is_on_floor():
			OnG = true;
		else:
			OnG = false;
		#SET DIRECTION
		if Movement.x > 0:
			Direction = 1
		if Movement.x < 0:
			Direction = -1
		#anim
		if boolAttack == false:
			if Direction == -1:
				$Body.set_flip_h(false)
				$Legs.set_flip_h(false)
			if Direction == 1:
				$Body.set_flip_h(true)
				$Legs.set_flip_h(true)
			#animG
			if Movement.x != 0 and OnG:
				$AshAnim.play("Run")
			if Movement.x == 0 and OnG:
				$AshAnim.play("Idle")
			if Movement.y < 0 and OnG == false:
				$AshAnim.play("Jump")
			if Movement.y == 0 and OnG == false:
				$AshAnim.play("Jump at Fall")
		else:
			$AshAnim.play("Attack1")
		#General Movement
		Movement.y += Gravity;
		Movement = move_and_slide(Movement, FLOOR);
	$GUI/TextureProgress.set_value(Heart)
func Damage(Damage):
	Heart += Damage
func disableTrack():
	if boolAttack == true:
		$AshAnim.get_animation("Idle").track_is_enabled("Body:frame")
		$AshAnim.find_animation("Run").find_track($Body).track_set_enabled(true)
func attack():
	if (!boolAttack):
		$AshAnim.play("Attack1")
		boolAttack = true
		yield($AshAnim,"animation_finished")
		boolAttack = false