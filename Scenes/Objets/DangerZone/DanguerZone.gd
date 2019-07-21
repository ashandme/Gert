extends Area2D
export var Damage = -1
var Phere = false
func _ready():
	pass
func _on_DanguerZone_body_entered(body):
	if "Ash" in body.name:
		Phere = true
		if Phere == true:
			body.Damage(Damage)
func _on_DanguerZone_body_exited(body):
	if "Ash" in body.name:
		Phere = false