class_name CircuitComponent
extends Node
# Base circuit component

var comp_name

var leads : Dictionary = {
	"A" : BB.DISCONNECTED,
	"B" : BB.DISCONNECTED
}

func _ready():
	pass
