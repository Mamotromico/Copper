extends Node
# Simulation Scene


func _ready():
	$Control/Button.connect("pressed", self, "toggle_render")
	pass


func toggle_render():
	if $Node2D.visible:
		$Node2D.hide()
		$Spatial.show()
	else:
		$Node2D.show()
		$Spatial.hide()
