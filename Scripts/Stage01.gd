extends Node2D
func _ready():
	$SeeGold.play()
func _on_OutScene_body_entered(body):
	get_tree().reload_current_scene()
