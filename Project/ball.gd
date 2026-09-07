extends Sprite2D

var distancesqr
var clicked:bool = false
@onready var r = $"../Line".position.x + 100
@onready var l = $"../Line".position.x - 100


func _process(_delta: float) -> void:
	distancesqr = get_global_mouse_position().distance_squared_to($".".global_position)
	if Input.is_action_just_pressed("leftclick") and distancesqr < 1600:
		clicked = true
	if Input.is_action_just_released("leftclick") :
		clicked = false
	if clicked == true:
		if $".".position[0] <= r and $".".position[0] >= l:
			$".".position[0] = int(get_global_mouse_position()[0] / 2) * 2
		if $".".position[0] > r:
			$".".position[0] = r
		if $".".position[0] < l:
			$".".position[0] = l
	GlobalVariable.bpmsecs = int(($".".position[0] * -1 + r)/3 + 9)
