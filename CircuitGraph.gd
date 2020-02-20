class_name CircuitGraph

var circuit_dictionary: Dictionary

func _ready():
	pass # Replace with function body.
	
func add_component(component, values = null):
	circuit_dictionary[component.get_instance_id()] = values
