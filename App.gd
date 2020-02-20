extends Node2D

var Component_Mode : String = ""
var cobj : CircuitComponent = null

var ccobj = preload("res://components/CircuitComponent.tscn")

var b_battery
var b_resistor
var b_wire

var circuit_graph : CircuitGraph

# Called when the node enters the scene tree for the first time.
func _ready():
	b_battery = $gui/viewContainer/sidebar/background/toolsContainer/buttons/battery
	b_resistor = $gui/viewContainer/sidebar/background/toolsContainer/buttons/resistor
	b_wire = $gui/viewContainer/sidebar/background/toolsContainer/buttons/wire
	b_battery.connect("change_component", self,  "set_component")
	b_resistor.connect("change_component", self, "set_component")
	b_wire.connect("change_component", self, "set_component")
	circuit_graph = CircuitGraph.new()
	print(JavaScript.eval("aluno()"))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (cobj):
		cobj.position = $breadboard.get_local_mouse_position()
	
func set_component(component):
	Component_Mode = component
	match Component_Mode:
		"BATTERY":
			cobj = ccobj.instance()
			cobj.set_texture(b_battery.get_normal_texture())
		"RESISTOR":
			cobj = ccobj.instance()
			cobj.set_texture(b_resistor.get_normal_texture())
		"WIRE":
			cobj = ccobj.instance()
			cobj.set_texture(b_wire.get_normal_texture())
			cobj.scale.x = 0
	$breadboard.add_child(cobj)
	
func _input(event):
	if (event is InputEventMouseButton):
		if (event.is_pressed()):
			if(event.button_index == 1):
				if(cobj):
					var nobj = cobj.duplicate()
					nobj.position = $breadboard.get_local_mouse_position()
					$breadboard.add_child(nobj)
					$breadboard.remove_child(cobj)		
					cobj = null
					circuit_graph.add_component(nobj)
			if(event.button_index == 4):
				if(cobj):
					cobj.rotation_degrees -= 45
					if (cobj.rotation_degrees < 0):
						cobj.rotation_degrees += 360
			if(event.button_index == 5):
				if(cobj):
					cobj.rotation_degrees += 45
					if (cobj.rotation_degrees > 360):
						cobj.rotation_degrees -= 360
