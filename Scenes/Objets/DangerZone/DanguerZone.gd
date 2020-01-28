extends Area2D
export var Damage = -1
func _ready():
	pass
func _on_DanguerZone_body_entered(body):
	while "Ash" in body.name:
		body.Damage(Damage)