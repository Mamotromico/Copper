class_name CircuitRow
extends Reference
# Breadboard row abstraction to limit connections

var _width : int
var _row : Array

func _init(size : int):
	_row.clear()
	_row.resize(size)
	for row in range(size):
		_row[row] = null
	_width = size
