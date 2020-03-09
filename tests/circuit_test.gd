extends WAT.Test

var circuit : Circuit

func title():
	return "Circuit creation"

func start() -> void:
	circuit = Circuit.new()

func pre():
	randomize()

func post():
	pass

func end() -> void:
	circuit.free()
	pass

func test_circuit_row_initialization():
	describe("Circuit Row Initialization")
	# Arrange
	var bus_array = [Circuit.BUSA_NEGATIVE, Circuit.BUSA_POSITIVE, Circuit.BUSB_NEGATIVE, Circuit.BUSB_POSITIVE]
	var rand_power_bus = circuit.get_board()[bus_array[randi() % 4]]
	var rand_row = circuit.get_board()[Vector2(Circuit.BUS_A, randi() % Circuit.BUS_LENGTH)]
	# Act
	# Assert
	asserts.is_class_instance(rand_row, CircuitRow, "Random row is the correct class")
	asserts.is_equal(rand_row._row.size(), 5, "Random row is the correct size")
	asserts.is_class_instance(rand_power_bus, CircuitRow, "Random power bus is the correct class")
	asserts.is_equal(rand_power_bus._row.size(), 50, "Random power bus is the correct size")
