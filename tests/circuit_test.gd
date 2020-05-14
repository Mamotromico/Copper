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
	var circuit = Circuit.new()
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
	var circuit = Circuit.new()
	var c1 = CircuitComponent.new()
	var position : int = randi() % BB.BUS_LENGTH
	var row = circuit.breadboard[Vector2(BB.BUS_A, position)]

	# Act
	c1.leads["A"] = row.insert_lead(c1, Vector2(BB.BUS_A, position))

	# Assert
	asserts.is_class_instance(c1, CircuitComponent, "component is the correct class")
	asserts.is_equal(c1.leads["A"], Vector2(BB.BUS_A, position), "component lead holds the correct position")
	asserts.is_true(circuit.breadboard.has(c1.leads["A"]), "component reference is on the breadboard")

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
	var circuit = Circuit.new()
#	var battery = BatteryComponent.new()
#	battery.leads["A"] = circuit.breadboard[BB.BUS_A_POSITIVE].insert_lead(battery, BB.BUS_A_POSITIVE)
#	battery.leads["B"] = circuit.breadboard[BB.BUS_A_NEGATIVE].insert_lead(battery, BB.BUS_A_NEGATIVE)

	var resistor1 : ResistorComponent = ResistorComponent.new()
	resistor1.comp_name = "R1"
	resistor1.bands.color_1 = BB.BLACK_B
	resistor1.bands.color_2 = BB.GREEN_B
	resistor1.bands.color_3 = BB.RED_B
	resistor1.bands.multiplier = BB.RED_M
	resistor1.bands.tolerance = BB.BROWN_T
	resistor1.bands.ppm = BB.BROWN_P
	resistor1.leads["A"] = circuit.breadboard[Vector2(BB.BUS_A, 1)].insert_lead(resistor1, Vector2(BB.BUS_A, 1))
	resistor1.leads["B"] = circuit.breadboard[Vector2(BB.BUS_A, 2)].insert_lead(resistor1, Vector2(BB.BUS_A, 2))

	var resistor2 : ResistorComponent = ResistorComponent.new()
	resistor2.comp_name = "R2"
	resistor2.bands.color_1 = BB.BLACK_B
	resistor2.bands.color_2 = BB.GREEN_B
	resistor2.bands.color_3 = BB.RED_B
	resistor2.bands.multiplier = BB.RED_M
	resistor2.bands.tolerance = BB.BROWN_T
	resistor2.bands.ppm = BB.BROWN_P
	resistor2.leads["A"] = circuit.breadboard[Vector2(BB.BUS_A, 2)].insert_lead(resistor2, Vector2(BB.BUS_A, 2))
	resistor2.leads["B"] = circuit.breadboard[Vector2(BB.BUS_A, 3)].insert_lead(resistor2, Vector2(BB.BUS_A, 3))

	var resistor3 : ResistorComponent = ResistorComponent.new()
	resistor3.comp_name = "R3"
	resistor3.bands.color_1 = BB.BLACK_B
	resistor3.bands.color_2 = BB.GREEN_B
	resistor3.bands.color_3 = BB.RED_B
	resistor3.bands.multiplier = BB.RED_M
	resistor3.bands.tolerance = BB.BROWN_T
	resistor3.bands.ppm = BB.BROWN_P
	resistor3.leads["A"] = circuit.breadboard[Vector2(BB.BUS_A, 2)].insert_lead(resistor3, Vector2(BB.BUS_A, 2))
	resistor3.leads["B"] = circuit.breadboard[Vector2(BB.BUS_A, 3)].insert_lead(resistor3, Vector2(BB.BUS_A, 3))

	var resistor4 : ResistorComponent = ResistorComponent.new()
	resistor4.comp_name = "R4"
	resistor4.bands.color_1 = BB.BLACK_B
	resistor4.bands.color_2 = BB.GREEN_B
	resistor4.bands.color_3 = BB.RED_B
	resistor4.bands.multiplier = BB.RED_M
	resistor4.bands.tolerance = BB.BROWN_T
	resistor4.bands.ppm = BB.BROWN_P
	resistor4.leads["A"] = circuit.breadboard[Vector2(BB.BUS_A, 3)].insert_lead(resistor4, Vector2(BB.BUS_A, 3))
	resistor4.leads["B"] = circuit.breadboard[Vector2(BB.BUS_A, 4)].insert_lead(resistor4, Vector2(BB.BUS_A, 4))

	var resistor5 : ResistorComponent = ResistorComponent.new()
	resistor5.comp_name = "R5"
	resistor5.bands.color_1 = BB.BLACK_B
	resistor5.bands.color_2 = BB.GREEN_B
	resistor5.bands.color_3 = BB.RED_B
	resistor5.bands.multiplier = BB.RED_M
	resistor5.bands.tolerance = BB.BROWN_T
	resistor5.bands.ppm = BB.BROWN_P
	resistor5.leads["A"] = circuit.breadboard[Vector2(BB.BUS_A, 4)].insert_lead(resistor5, Vector2(BB.BUS_A, 4))
	resistor5.leads["B"] = circuit.breadboard[Vector2(BB.BUS_A, 1)].insert_lead(resistor5, Vector2(BB.BUS_A, 1))



	# Act

#	var list = circuit.get_connection_list()
#	for entry in list:
#		print(entry, " === ", list[entry])
#
#	var second_list = circuit.get_loops()
#	for entry in second_list:
#		print(entry, " --- ", second_list[entry])
		
	var list = circuit.m_get_connection_list()
	for entry in list:
		print(entry, " === ", list[entry])
		
#	var second_list = circuit.m_get_loops()
#	for entry in second_list:
#		print(entry, " --- ", second_list[entry])

	# Assert
	pass
