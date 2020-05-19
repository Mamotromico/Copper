class_name CircuitNode
extends Resource

var full = false
var comp_connected = false
var row_neighbors = []

func is_full() -> bool:
	if comp_connected:
		return true
	else:
		return false

func insert_lead(component : CircuitComponent, lead):
	if not comp_connected:
		comp_connected = component
		return lead
	else:
		push_error("Could not insert lead on %s, node is occupied" % [lead])
		return BB.INVALID

func remove_lead(lead):
	if comp_connected:
		comp_connected = false
		return lead
	else:
		push_error("Could not find lead %s in this node" % [lead])
		return BB.INVALID
