#extends AnimatedSprite2D
#
#var distancesqr:float
#var mousepos
#var clickhelper = 1
#var currentrotate = 0
#var arotate
#var helper
#
#
#func _ready():
	#arotate = -2.1
	#currentrotate = -2.1
#
#func _process(_delta: float) -> void:
	#helper = int(27 - 27 * arotate / (PI / 2))
	#frame = helper + 27 * floor(arotate / (PI / 2))
	#if helper >= 54:
		#$".".rotation = PI / -2
	#if helper >= 27 and helper < 54:
		#$".".rotation = 0
	#if helper >= 0 and helper < 27:
		#$".".rotation = PI / 2
	#if helper >= -27 and helper < 0:
		#$".".rotation = PI
	#distancesqr = get_global_mouse_position().distance_squared_to($".".global_position)
	#if distancesqr < 1600 * clickhelper and Input.is_action_pressed("leftbutton") == true:
		#clicked()
	#if Input.is_action_just_released("leftbutton") == true:
		#currentrotate = arotate
		#clickhelper = 1
	#Globaltest.attack = float(int((currentrotate/2.09999990463256 + 1) * 25)) / 10
	#
#
#func clicked():
		#mousepos = get_global_mouse_position()
		#clickhelper = 100000000
		#if arotate <= 2.1 and arotate >= -2.1:
			#arotate = currentrotate + (Globaltest.mouse_origin[1] - mousepos[1]) /60
		#if arotate < -2.1:
			#arotate = -2.1
		#if arotate > 2.1:
			#arotate = 2.1
