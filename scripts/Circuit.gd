class_name Circuit
extends Resource
# Breadboard abstraction to represent the whole circuit

var breadboard : Dictionary

func _init():
	breadboard[BB.BUS_A_NEGATIVE] = CircuitRow.new(50)
	breadboard[BB.BUS_A_POSITIVE] = CircuitRow.new(50)

	breadboard[BB.BUS_B_NEGATIVE] = CircuitRow.new(50)
	breadboard[BB.BUS_B_POSITIVE] = CircuitRow.new(50)

	for row in range(BB.BUS_LENGTH):
		breadboard[Vector2(BB.BUS_A, row)] = CircuitRow.new(5)
		breadboard[Vector2(BB.BUS_B, row)] = CircuitRow.new(5)


func _ready():
	pass
