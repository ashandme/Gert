extends StaticBody2D



func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _on_VisibilityNotifier2D_screen_entered():
	$Wallspr.set_visible(true)


func _on_VisibilityNotifier2D_screen_exited():
	$Wallspr.set_visible(false)
