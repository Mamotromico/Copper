class_name CircuitComponent
extends Node
# Base circuit component

enum {A, B}

var leads : Dictionary = {
	A = BB.DISCONNECTED,
	B = BB.DISCONNECTED
}


func _ready():
	pass
