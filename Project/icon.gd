extends Area2D

var state:String = "sitting"


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()


func on_click():
	GlobalVariable.selected = 1
	if state == "sitting":
		state = "waiting"


func _process(_delta: float) -> void:
	if not GlobalVariable.selected == 1:
		state = "sitting"
