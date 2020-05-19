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



func test_circuit_insertion():
	describe("Insert component on breadboard")

	# Arrange
	var circuit = Circuit.new()
	var c1 = CircuitComponent.new()
	var p1 : int = randi() % BB.BUS_WIDTH*2
	var p2 : int = randi() % BB.BUS_LENGTH
	var node = circuit.breadboard[Vector2(p1+1,p2+1)]

	# Act
	c1.leads["A"] = node.insert_lead(c1, Vector2(p1, p2))

	# Assert
	asserts.is_class_instance(c1, CircuitComponent, "component is the correct class")
	asserts.is_equal(c1.leads["A"], Vector2(p1, p2), "component lead holds the correct position")
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

#func test_mock_circuit_1():
#	describe("Simple circuit with battery and resistance")
#	# Arrange
#	var circuit = Circuit.new()
#
#	var resistor1 : ResistorComponent = ResistorComponent.new()
#	resistor1.comp_name = "R1"
#	resistor1.bands.color_1 = BB.BLACK_B
#	resistor1.bands.color_2 = BB.GREEN_B
#	resistor1.bands.color_3 = BB.RED_B
#	resistor1.bands.multiplier = BB.RED_M
#	resistor1.bands.tolerance = BB.BROWN_T
#	resistor1.bands.ppm = BB.BROWN_P
#	resistor1.leads["A"] = circuit.breadboard[Vector2(1, 1)].insert_lead(resistor1, Vector2(1, 1))
#	resistor1.leads["B"] = circuit.breadboard[Vector2(1, 2)].insert_lead(resistor1, Vector2(1, 2))
#
#	var resistor2 : ResistorComponent = ResistorComponent.new()
#	resistor2.comp_name = "R2"
#	resistor2.bands.color_1 = BB.BLACK_B
#	resistor2.bands.color_2 = BB.GREEN_B
#	resistor2.bands.color_3 = BB.RED_B
#	resistor2.bands.multiplier = BB.RED_M
#	resistor2.bands.tolerance = BB.BROWN_T
#	resistor2.bands.ppm = BB.BROWN_P
#	resistor2.leads["A"] = circuit.breadboard[Vector2(2, 2)].insert_lead(resistor2, Vector2(2, 2))
#	resistor2.leads["B"] = circuit.breadboard[Vector2(2, 3)].insert_lead(resistor2, Vector2(2, 3))
#
#	var resistor3 : ResistorComponent = ResistorComponent.new()
#	resistor3.comp_name = "R3"
#	resistor3.bands.color_1 = BB.BLACK_B
#	resistor3.bands.color_2 = BB.GREEN_B
#	resistor3.bands.color_3 = BB.RED_B
#	resistor3.bands.multiplier = BB.RED_M
#	resistor3.bands.tolerance = BB.BROWN_T
#	resistor3.bands.ppm = BB.BROWN_P
#	resistor3.leads["A"] = circuit.breadboard[Vector2(3, 2)].insert_lead(resistor3, Vector2(3, 2))
#	resistor3.leads["B"] = circuit.breadboard[Vector2(3, 3)].insert_lead(resistor3, Vector2(3, 3))
#
#	var resistor4 : ResistorComponent = ResistorComponent.new()
#	resistor4.comp_name = "R4"
#	resistor4.bands.color_1 = BB.BLACK_B
#	resistor4.bands.color_2 = BB.GREEN_B
#	resistor4.bands.color_3 = BB.RED_B
#	resistor4.bands.multiplier = BB.RED_M
#	resistor4.bands.tolerance = BB.BROWN_T
#	resistor4.bands.ppm = BB.BROWN_P
#	resistor4.leads["A"] = circuit.breadboard[Vector2(1, 3)].insert_lead(resistor4, Vector2(1, 3))
#	resistor4.leads["B"] = circuit.breadboard[Vector2(1, 4)].insert_lead(resistor4, Vector2(1, 4))
#
#	var resistor5 : ResistorComponent = ResistorComponent.new()
#	resistor5.comp_name = "R5"
#	resistor5.bands.color_1 = BB.BLACK_B
#	resistor5.bands.color_2 = BB.GREEN_B
#	resistor5.bands.color_3 = BB.RED_B
#	resistor5.bands.multiplier = BB.RED_M
#	resistor5.bands.tolerance = BB.BROWN_T
#	resistor5.bands.ppm = BB.BROWN_P
#	resistor5.leads["A"] = circuit.breadboard[Vector2(2, 4)].insert_lead(resistor5, Vector2(2, 4))
#	resistor5.leads["B"] = circuit.breadboard[Vector2(4, 1)].insert_lead(resistor5, Vector2(4, 1))
#
#
#
#	# Act
#
#	var list = circuit.get_connection_list()
#	for entry in list:
#		print(entry, " === ", list[entry])
#
#	var second_list = circuit.get_loops()
#	for entry in second_list:
#		print(entry, " --- ", second_list[entry])
#
#
#	# Assert
#	pass
	
func test_mock_circuit_2():
	describe("Simple circuit with battery and resistance")
	# Arrange
	var circuit = Circuit.new()

	var resistor1 : ResistorComponent = ResistorComponent.new()
	resistor1.comp_name = "R1"
	resistor1.bands.color_1 = BB.BLACK_B
	resistor1.bands.color_2 = BB.GREEN_B
	resistor1.bands.color_3 = BB.RED_B
	resistor1.bands.multiplier = BB.RED_M
	resistor1.bands.tolerance = BB.BROWN_T
	resistor1.bands.ppm = BB.BROWN_P
	resistor1.leads["A"] = circuit.breadboard[Vector2(1, 1)].insert_lead(resistor1, Vector2(1, 1))
	resistor1.leads["B"] = circuit.breadboard[Vector2(1, 4)].insert_lead(resistor1, Vector2(1, 4))

	var resistor2 : ResistorComponent = ResistorComponent.new()
	resistor2.comp_name = "R2"
	resistor2.bands.color_1 = BB.BLACK_B
	resistor2.bands.color_2 = BB.GREEN_B
	resistor2.bands.color_3 = BB.RED_B
	resistor2.bands.multiplier = BB.RED_M
	resistor2.bands.tolerance = BB.BROWN_T
	resistor2.bands.ppm = BB.BROWN_P
	resistor2.leads["A"] = circuit.breadboard[Vector2(2, 1)].insert_lead(resistor2, Vector2(2, 1))
	resistor2.leads["B"] = circuit.breadboard[Vector2(2, 4)].insert_lead(resistor2, Vector2(2, 4))

	var resistor3 : ResistorComponent = ResistorComponent.new()
	resistor3.comp_name = "R3"
	resistor3.bands.color_1 = BB.BLACK_B
	resistor3.bands.color_2 = BB.GREEN_B
	resistor3.bands.color_3 = BB.RED_B
	resistor3.bands.multiplier = BB.RED_M
	resistor3.bands.tolerance = BB.BROWN_T
	resistor3.bands.ppm = BB.BROWN_P
	resistor3.leads["A"] = circuit.breadboard[Vector2(3, 1)].insert_lead(resistor3, Vector2(3, 5))
	resistor3.leads["B"] = circuit.breadboard[Vector2(3, 5)].insert_lead(resistor3, Vector2(3, 5))

	var resistor4 : ResistorComponent = ResistorComponent.new()
	resistor4.comp_name = "R4"
	resistor4.bands.color_1 = BB.BLACK_B
	resistor4.bands.color_2 = BB.GREEN_B
	resistor4.bands.color_3 = BB.RED_B
	resistor4.bands.multiplier = BB.RED_M
	resistor4.bands.tolerance = BB.BROWN_T
	resistor4.bands.ppm = BB.BROWN_P
	resistor4.leads["A"] = circuit.breadboard[Vector2(4, 1)].insert_lead(resistor4, Vector2(4, 1))
	resistor4.leads["B"] = circuit.breadboard[Vector2(4, 6)].insert_lead(resistor4, Vector2(4, 6))

	var resistor5 : ResistorComponent = ResistorComponent.new()
	resistor5.comp_name = "R5"
	resistor5.bands.color_1 = BB.BLACK_B
	resistor5.bands.color_2 = BB.GREEN_B
	resistor5.bands.color_3 = BB.RED_B
	resistor5.bands.multiplier = BB.RED_M
	resistor5.bands.tolerance = BB.BROWN_T
	resistor5.bands.ppm = BB.BROWN_P
	resistor5.leads["A"] = circuit.breadboard[Vector2(5, 1)].insert_lead(resistor5, Vector2(5, 1))
	resistor5.leads["B"] = circuit.breadboard[Vector2(5, 6)].insert_lead(resistor5, Vector2(5, 6))
	
	var resistor6 : ResistorComponent = ResistorComponent.new()
	resistor6.comp_name = "R6"
	resistor6.bands.color_1 = BB.BLACK_B
	resistor6.bands.color_2 = BB.GREEN_B
	resistor6.bands.color_3 = BB.RED_B
	resistor6.bands.multiplier = BB.RED_M
	resistor6.bands.tolerance = BB.BROWN_T
	resistor6.bands.ppm = BB.BROWN_P
	resistor6.leads["A"] = circuit.breadboard[Vector2(2, 5)].insert_lead(resistor6, Vector2(2, 5))
	resistor6.leads["B"] = circuit.breadboard[Vector2(3, 4)].insert_lead(resistor6, Vector2(3, 4))
	
	var resistor7 : ResistorComponent = ResistorComponent.new()
	resistor7.comp_name = "R7"
	resistor7.bands.color_1 = BB.BLACK_B
	resistor7.bands.color_2 = BB.GREEN_B
	resistor7.bands.color_3 = BB.RED_B
	resistor7.bands.multiplier = BB.RED_M
	resistor7.bands.tolerance = BB.BROWN_T
	resistor7.bands.ppm = BB.BROWN_P
	resistor7.leads["A"] = circuit.breadboard[Vector2(3, 6)].insert_lead(resistor7, Vector2(3, 6))
	resistor7.leads["B"] = circuit.breadboard[Vector2(4, 5)].insert_lead(resistor7, Vector2(4, 5))
	
	var resistor8 : ResistorComponent = ResistorComponent.new()
	resistor8.comp_name = "R8"
	resistor8.bands.color_1 = BB.BLACK_B
	resistor8.bands.color_2 = BB.GREEN_B
	resistor8.bands.color_3 = BB.RED_B
	resistor8.bands.multiplier = BB.RED_M
	resistor8.bands.tolerance = BB.BROWN_T
	resistor8.bands.ppm = BB.BROWN_P
	resistor8.leads["A"] = circuit.breadboard[Vector2(2, 6)].insert_lead(resistor8, Vector2(2, 6))
	resistor8.leads["B"] = circuit.breadboard[Vector2(4, 4)].insert_lead(resistor8, Vector2(4, 4))



	# Act

	var list = circuit.m_get_connection_list()

	var file = File.new()
	file.open("user://adj_matrix.csv", File.WRITE)
	var line_write = []
	line_write.append("0000")
	for entry in list.keys():
		line_write.append(entry)
	file.store_csv_line(line_write)
	line_write.clear()
	for entry in list.keys():
		line_write.empty()
		line_write.append(entry)
		for lentry in list.keys():
			line_write.append(list[entry][lentry])
		file.store_csv_line(line_write)
		line_write.clear()
	file.close()
	
	list = circuit.m_get_spanning_tree()

	file = File.new()
	file.open("user://spn_matrix.csv", File.WRITE)
	line_write = []
	line_write.append("0000")
	for entry in list.keys():
		line_write.append(entry)
	file.store_csv_line(line_write)
	line_write.clear()
	for entry in list.keys():
		line_write.empty()
		line_write.append(entry)
		for lentry in list.keys():
			line_write.append(list[entry][lentry])
		file.store_csv_line(line_write)
		line_write.clear()
	file.close()

	# Assert
	pass
