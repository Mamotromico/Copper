class_name CircuitRow
extends Resource
# Breadboard row abstraction to limit connections

var width : int
var row = []

func _init(size : int):
	self.width = size

func is_full() -> bool:
	if self.row.size >= width:
		return true
	else:
		return false

func insert_lead(component : CircuitComponent, lead):
	if self.row.size() < self.width:
		self.row.append(component)
		return lead
	else:
		push_error("Could not insert lead on %s, the row is full" % [lead])
		return BB.INVALID

func remove_lead(component : CircuitComponent, lead):
	if row.has(component):
		row.erase(component)
		return lead
	else:
		push_error("Could not find lead %s in this row" % [lead])
		return BB.INVALID
