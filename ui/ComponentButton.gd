extends TextureButton

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

class_name ComponentButton

export var component : String
signal change_component

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pressed():
	print(component.to_upper())
	emit_signal("change_component", component.to_upper())
