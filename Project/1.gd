extends Area2D

var state:String = "sitting"
var assignedpitch:int = 0
var dualstep:int

func _ready() -> void:
	if get_parent().position.y > 0:
		dualstep = int(get_parent().name) - 8
	else:
		dualstep = int(get_parent().name)


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()


func on_click():
	GlobalVariable.selected = int(get_parent().name) + GlobalVariable.page * 16


func _process(_delta: float) -> void:
	if not GlobalVariable.selected == int(get_parent().name) + GlobalVariable.page * 16:
		state = "sitting"
	else:
		state = "waiting"
	if state == "waiting" and GlobalVariable.notepressed == true:
		GlobalVariable.selected = 0
		GlobalVariable.sequence[int(get_parent().name) - 1 + GlobalVariable.page * 16] = GlobalVariable.latestnote
		if get_parent().position.y > 0:
			GlobalVariable.dualsequence[int(get_parent().name) - 1 + 8 + GlobalVariable.page * 8] = GlobalVariable.latestnote
		else:
			GlobalVariable.dualsequence[int(get_parent().name) - 1 + GlobalVariable.page * 8] = GlobalVariable.latestnote
		print(GlobalVariable.dualsequence)
	elif state == "waiting" and Input.is_action_just_pressed("Delete"):
		state = "sitting"
		GlobalVariable.sequence[int(get_parent().name) - 1 + GlobalVariable.page * 16] = 0
		GlobalVariable.selected = 0
		if get_parent().position.y > 0:
			GlobalVariable.dualsequence[int(get_parent().name) - 1 + 8 + GlobalVariable.page * 8] = 0
		else:
			GlobalVariable.dualsequence[int(get_parent().name) - 1 + GlobalVariable.page * 8] = 0
		print(GlobalVariable.dualsequence)
	if GlobalVariable.mode == "Normal": 
		if int(get_parent().name) + GlobalVariable.page * 16 > GlobalVariable.stepamount:
			$"..".frame = 4
		elif GlobalVariable.step == int(get_parent().name) + GlobalVariable.page * 16:
			$"..".frame = 3
		elif state == "waiting":
			$"..".frame = 1
		elif not (GlobalVariable.sequence[int(get_parent().name) - 1 + GlobalVariable.page * 16]) == 0:
			$"..".frame = 2
		elif state == "sitting":
			$"..".frame = 0
	else:
		if dualstep + GlobalVariable.page * 8 > GlobalVariable.stepamountdual:
			$"..".frame = 4
		elif GlobalVariable.step == dualstep + GlobalVariable.page * 16:
			$"..".frame = 3
		elif state == "waiting":
			$"..".frame = 1
		elif not (GlobalVariable.sequence[int(get_parent().name) - 1 + GlobalVariable.page * 16]) == 0:
			$"..".frame = 2
		elif state == "sitting":
			$"..".frame = 0
