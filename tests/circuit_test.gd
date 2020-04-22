extends WAT.Test

func title():
	return "Circuit creation"


func start() -> void:
	pass


func pre():
	randomize()


func post():
	pass


func end() -> void:
	pass


func test_circuit_row_initialization():
	describe("Circuit Row Initialization")
	# Arrange
	var circuit : Circuit = Circuit.new()
	var bus_array = [BB.BUS_A_NEGATIVE, BB.BUS_A_POSITIVE, BB.BUS_B_NEGATIVE, BB.BUS_B_POSITIVE]
	var rand_power_bus = circuit.breadboard[bus_array[randi() % 4]]
	var rand_row = circuit.breadboard[Vector2(BB.BUS_A, randi() % BB.BUS_LENGTH)]

	# Act

	# Assert
	asserts.is_class_instance(rand_row, CircuitRow, "Random row is the correct class")
	asserts.is_class_instance(rand_power_bus, CircuitRow, "Random power bus is the correct class")


func test_circuit_insertion():
	describe("Insert component on breadboard")

	# Arrange
	var circuit : Circuit = Circuit.new()
	var c1 : CircuitComponent = CircuitComponent.new()
	var position : int = randi() % BB.BUS_LENGTH
	var row : CircuitRow = circuit.breadboard[Vector2(BB.BUS_A, position)]

	# Act
	c1.leads[c1.A] = row.insert_lead(c1, Vector2(BB.BUS_A, position))

	# Assert
	asserts.is_class_instance(c1, CircuitComponent, "component is the correct class")
	asserts.is_equal(c1.leads[c1.A], Vector2(BB.BUS_A, position), "component lead holds the correct position")
	asserts.is_true(circuit.breadboard.has(c1.leads[c1.A]), "component reference is on the breadboard")

func test_resistor_values():
	describe("Ensure resistance is calculated correctly")
	# Arrange
	var resistor : ResistorComponent = ResistorComponent.new()
	resistor.bands.color_1 = BB.BLACK_B
	resistor.bands.color_2 = BB.GREEN_B
	resistor.bands.color_3 = BB.RED_B
	resistor.bands.multiplier = BB.RED_M
	resistor.bands.tolerance = BB.BROWN_T
	resistor.bands.ppm = BB.BROWN_P

	# Act

	# Assert
	asserts.is_equal(resistor.resistance, 5200, "Color banding is correct")

func test_mock_circuit():
	describe("Simple circuit with battery and resistance")
	# Arrange
	var circuit : Circuit = Circuit.new()
	var battery : BatteryComponent = BatteryComponent.new()
	battery.leads[battery.A] = circuit.breadboard[BB.BUS_A_POSITIVE].insert_lead(battery, BB.BUS_A_POSITIVE)
	battery.leads[battery.B] = circuit.breadboard[BB.BUS_A_NEGATIVE].insert_lead(battery, BB.BUS_A_NEGATIVE)

	var resistor : ResistorComponent = ResistorComponent.new()
	resistor.bands.color_1 = BB.BLACK_B
	resistor.bands.color_2 = BB.GREEN_B
	resistor.bands.color_3 = BB.RED_B
	resistor.bands.multiplier = BB.RED_M
	resistor.bands.tolerance = BB.BROWN_T
	resistor.bands.ppm = BB.BROWN_P
	resistor.leads[resistor.A] = circuit.breadboard[BB.BUS_A_POSITIVE].insert_lead(resistor, BB.BUS_A_POSITIVE)
	resistor.leads[resistor.B] = circuit.breadboard[BB.BUS_A_NEGATIVE].insert_lead(resistor, BB.BUS_A_NEGATIVE)

	# Act

	print("Positive Bus A ")
	print(circuit.breadboard[BB.BUS_A_POSITIVE].row)
	print("Negative Bus A ")
	print(circuit.breadboard[BB.BUS_A_NEGATIVE].row)

	# Assert
	pass
