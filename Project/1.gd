extends Area2D

var state:String = "sitting"
var assignedpitch:int = 0


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
		GlobalVariable.sequence[int(get_parent().name) - 1] = GlobalVariable.latestnote
	elif state == "waiting" and Input.is_action_just_pressed("Delete"):
		state = "sitting"
		GlobalVariable.sequence[int(get_parent().name) - 1] = 0
		GlobalVariable.selected = 0
	if GlobalVariable.step == int(get_parent().name):
		$"..".frame = 3
	elif state == "waiting":
		$"..".frame = 1
	elif not (GlobalVariable.sequence[int(get_parent().name) - 1]) == 0:
		$"..".frame = 2
	elif state == "sitting":
		$"..".frame = 0
	
