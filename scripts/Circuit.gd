class_name Circuit
extends Node
# Breadboard abstraction to represent the whole circuit


const DISCONNECTED = Vector2(-1,0)
const BUSA_NEGATIVE = Vector2(-1,-1)
const BUSA_POSITIVE = Vector2(-1,1)
const BUSB_NEGATIVE = Vector2(-1,-2)
const BUSB_POSITIVE = Vector2(-1,2)
const BUS_LENGTH = 63
const BUS_WIDTH = 5
const BUS_A = 1
const BUS_B = 2

var _breadboard:Dictionary


func _init():
	_breadboard[BUSA_NEGATIVE] = CircuitRow.new(50)
	_breadboard[BUSA_POSITIVE] = CircuitRow.new(50)

	_breadboard[BUSB_NEGATIVE] = CircuitRow.new(50)
	_breadboard[BUSB_POSITIVE] = CircuitRow.new(50)

	for row in range(BUS_LENGTH):
		_breadboard[Vector2(BUS_A, row)] = CircuitRow.new(5)
		_breadboard[Vector2(BUS_B, row)] = CircuitRow.new(5)


func _ready():
	pass

func get_board():
	return _breadboard