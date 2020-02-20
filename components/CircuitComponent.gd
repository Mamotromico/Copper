extends Sprite

class_name CircuitComponent

signal component_node_clicked

func _ready():
	$left.connect("input_event", self, "click")
	$right.connect("input_event", self, "click")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func click( viewport, event, shapeidx ):
	if (event is InputEventMouseButton && event.pressed and event.button_index == BUTTON_LEFT):
		emit_signal("component_node_clicked", self)
