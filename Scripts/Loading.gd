extends Node

var load_finishes = false

func _ready():
	$Timer.start()
	$AnimationPlayer.play("play")

func _on_Timer_timeout():
	$AnimationPlayer.play("playr")
	load_finishes = true

func _on_AnimationPlayer_animation_finished(playr):
	if load_finishes == true:
		get_tree().change_scene("res://Scenes/Lobby.tscn")
