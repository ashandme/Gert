extends Node2D

var planet = 0
var ready = false
var end = false
func _ready():
	pass

func _process(delta):
	if planet != 0:
		ready = true
		if $AnimationPlayer.current_animation != "lol":
			$AnimationPlayer.play("lol")
		
	if end == true:
		get_tree().change_scene("res://Scenes/Planet1.tscn")

func _on_Planet_1_pressed():
	
	planet = 1

func _on_AnimationPlayer_animation_finished(lol):
	if ready == true:
		if planet == 1:
			end = true
		
		
