extends RichTextLabel

var mouseorigin
var mousepos
var distancesqr:float
var clickhelper = 1
var currentnumb = 16

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("leftclick") == true:
		mouseorigin = get_global_mouse_position()
	distancesqr = get_global_mouse_position().distance_squared_to($".".global_position)
	if distancesqr < 4000 * clickhelper and Input.is_action_pressed("leftclick") == true:
		clicked()
	if Input.is_action_just_released("leftclick") == true:
		clickhelper = 1
		currentnumb = int($".".text)
		GlobalVariable.stepamount = int($".".text)
		
func clicked():
	mousepos = get_global_mouse_position()
	clickhelper = 100000000
	if (currentnumb + int((mouseorigin[1] - mousepos[1]) /20)) < 17 and \
	(currentnumb + int((mouseorigin[1] - mousepos[1]) /20)) > 3:
		$".".text = str(currentnumb + int((mouseorigin[1] - mousepos[1]) /20))
	elif (currentnumb + int((mouseorigin[1] - mousepos[1]) /20)) > 10:
		$".".text = "16"
	else:
		$".".text = "4"
