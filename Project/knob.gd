extends AnimatedSprite2D

var distancesqr:float
var clickhelper = 1
var currentrotate = 0
var arotate
var helper
var mouseorig:float


func _ready():
	if self.name == "Attack":
		arotate = -2.1
		currentrotate = -2.1
	if self.name == "Release":
		arotate = 0
		currentrotate = 0
	if self.name == "Decay":
		arotate = 2.1
		currentrotate = 2.1
	if self.name == "Sustain":
		arotate = 2.1
		currentrotate = 2.1
	
	
func _process(_delta: float) -> void:
	helper = int(27 - 27 * arotate / (PI / 2))
	frame = helper + 27 * floor(arotate / (PI / 2))
	if helper >= 54:
		$".".rotation = PI / -2
	if helper >= 27 and helper < 54:
		$".".rotation = 0
	if helper >= 0 and helper < 27:
		$".".rotation = PI / 2
	if helper >= -27 and helper < 0:
		$".".rotation = PI
	if Input.is_action_just_pressed("leftclick") == true:
		mouseorig = get_global_mouse_position()[1]
	distancesqr = get_global_mouse_position().distance_squared_to($".".global_position)
	if distancesqr < 1600 * clickhelper and Input.is_action_pressed("leftclick") == true:
		if GlobalVariable.knobclicked == "Open" or GlobalVariable.knobclicked == self.name:
			clicked()
	if Input.is_action_just_released("leftclick") == true:
		GlobalVariable.knobclicked = "Open"
		currentrotate = arotate
		clickhelper = 1
	if self.name == "Attack":
		GlobalVariable.attack = float(int((currentrotate/2.09999990463256 + 1) * 50)) / 100
	if self.name == "Decay":
		GlobalVariable.decay = float(int((currentrotate/2.09999990463256 + 1) * 10)) / 10
	if self.name == "Sustain":
		GlobalVariable.sustain = int((currentrotate/2.09999990463256 + 1) * 50)
	if self.name == "Release":
		GlobalVariable.release = float(int((currentrotate/2.09999990463256 + 1) * 50)) / 10


func clicked():
	GlobalVariable.knobclicked = self.name
	clickhelper = 100000000
	if arotate <= 2.1 and arotate >= -2.1:
		arotate = currentrotate + (mouseorig - get_global_mouse_position()[1]) /60
	if arotate < -2.1:
		arotate = -2.1
	if arotate > 2.1:
		arotate = 2.1
