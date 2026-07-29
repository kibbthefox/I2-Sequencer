extends Area2D

var state:String = "sitting"
var pitch:int = 0


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()


func on_click():
	GlobalVariable.selected = int(get_parent().name)


func _process(_delta: float) -> void:
	if not GlobalVariable.selected == int(get_parent().name):
		state = "sitting"
	else:
		state = "waiting"
	if state == "waiting" and GlobalVariable.notepressed == true:
		GlobalVariable.selected = 0
		pitch = GlobalVariable.latestnote
		print(pitch)
	
