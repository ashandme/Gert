extends KinematicBody2D
export var Speed = 60

var Gravity = 15
var Movement = Vector2()
const Floor = Vector2(0, -1)
var Direction = 1
var Dead = false
export var Heart = 4

func _ready():
	pass
func Damage(var Damage):
	Heart -= Damage
	

func _physics_process(delta):
	Movement.x = Speed * Direction
	Movement.y += Gravity
	if !Dead:
		if Movement.x == 0:
			Movement.x = -Speed
		if Direction == -1:
			$animGruti.set_flip_h(true)
		else:
			$animGruti.set_flip_h(false)
		Movement = move_and_slide(Movement, Floor)
		if is_on_wall():
			Change_X()
		if $RayCastAlfa.is_colliding() == false:
			Change_X()
	if Heart == 1:
		if $animGruti/AnimationPlayer.current_animation != "Heart" and Dead == false:
			$animGruti/AnimationPlayer.play("Heart")
	if Heart <= 0:
		Dead = true
		$CollisionShape2D.set_disabled(true)
		if $animGruti/AnimationPlayer.current_animation != "Dead" and Dead == true:
			$animGruti/AnimationPlayer.play("Dead")
		$DanguerZone/CollisionShape2D.set_disabled(true)

func _on_AnimationPlayer_animation_finished(Dead):
	queue_free()
func Change_X():
	Direction = Direction * -1
	$RayCastAlfa.position.x *= -1

func _on_VisibilityNotifier2D_screen_entered():
	set_visible(true)


func _on_VisibilityNotifier2D_screen_exited():
	set_visible(false)
