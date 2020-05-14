class_name ResistorComponent
extends CircuitComponent

var resistance setget ,get_resistance

var bands : Dictionary = {
	color_1 = -1,
	color_2 = -1,
	color_3 = -1,
	multiplier = -1,
	tolerance = -1,
	ppm = -1
}

func _ready():
	pass

func get_resistance():
	return ((bands.color_1 * 100) + (bands.color_2 * 10) + (bands.color_3)) * bands.multiplier

func set_resistance(c1, c2, c3, m, t, p):
	bands.color_1 = c1
	bands.color_2 = c2
	bands.color_3 = c3
	bands.multiplier = m
	bands.tolerance = t
	bands.ppm = p
