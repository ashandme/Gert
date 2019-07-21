extends Node
func _ready():
	print("Ready For Start")
	$Control/VBoxContainer/Title.play("Title")
func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.stop()
func _on_Play_button_down():
	$Control/VBoxContainer.set_visible(false)
	if $Anim.is_playing() == false:
		$Anim.play("play")
func _on_Settings_button_down():
	pass 
func _on_Exit_button_down():
	get_tree().quit()
func _on_Anim_animation_finished(anim_name):
	if anim_name == "play":
		get_tree().change_scene("res://Scenes/Planet1.tscn")