extends KinematicBody2D
var Movement = Vector2();
var Gravity = 9;
var Jump = -220;
const FLOOR = Vector2(0 , -1);
var Speed = 70; 
var Direction = -1; #get direction for flip sprites
var OnG = false; #on Ground variable
var boolAttack = false
var Heart = 5;
func _physics_process(delta):
	if Heart > 0:
		#---|input|---#
		if Input.is_action_pressed("ui_right"):
			Movement.x = Speed;
		elif Input.is_action_pressed("ui_left"):
			Movement.x = -Speed;
		else:
			Movement.x = 0
		if Input.is_action_just_pressed("ui_cancel"):
			if OnG == true:
				Movement.y = Jump
		if Input.is_action_just_pressed("ui_accept"):
			attack()
		#--------|change the value of OnG if the character is on ground|--------#
		if is_on_floor():
			OnG = true;
		else:
			OnG = false;
		#--------|Set Direction|--------#
		if Movement.x > 0:
			Direction = 1
		if Movement.x < 0:
			Direction = -1
		if !boolAttack:
			Body_Animation()
			Flip_H()
		Legs_Animation()
		Movement.y += Gravity;
		Movement = move_and_slide(Movement, FLOOR);
	$GUI/TextureProgress.set_value(Heart)
func Body_Animation():
	if Movement.x != 0 and OnG:
		$Body/BodyAnim.play("Run")
	if Movement.x == 0 and OnG:
		$Body/BodyAnim.play("Idle")
	if Movement.y < 0 and !OnG:
		$Body/BodyAnim.play("Jump")
	if Movement.y > 0 and !OnG:
		$Body/BodyAnim.play("Jump at Fall")
func Legs_Animation():
	if Movement.x != 0 and OnG:
		$Legs/LegsAnim.play("Run")
	if Movement.x == 0 and OnG:
		$Legs/LegsAnim.play("Idle")
	if Movement.y < 0 and !OnG:
		$Legs/LegsAnim.play("Jump")
	if Movement.y > 0 and !OnG:
		$Legs/LegsAnim.play("Jump at Fall")		
func Flip_H():
	if Direction == -1:
		$Body.set_flip_h(false)
		$Legs.set_flip_h(false)
	if Direction == 1:
		$Body.set_flip_h(true)
		$Legs.set_flip_h(true)
func Damage(Damage):
	Heart += Damage
func attack():
	if (!boolAttack):
		$Body/BodyAnim.play("Attack1")
		boolAttack = true
		yield($Body/BodyAnim,"animation_finished")
		boolAttack = false	
		$Legs/LegsAnim.stop()
