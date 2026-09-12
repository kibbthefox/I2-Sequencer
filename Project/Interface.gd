extends Node2D

var BPMcalc:float
var play:bool = false
var notes:Array = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B"]
var whatsletgo:Array = ['m','k']
var midipitch:int = -1
var keyboardarr:Array = ["z","s","x","d","c","v","g","b","h","n","j","m",",","l",".",";","pianoe","q","2","w","3","e","r","5","t","6","y","7","u","i","9","o","0","p"]
var octavearr:Array = [1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,4,4,4,4,4]
var keydownhelparr:Array = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28]
var latestmidinote:int = 0
var latestkeyboardnote:String
var pitcharray:Array = [1,1.0595,1.1225,1.1892,1.2599,1.3348,1.4142,1.4983,1.5874,1.6818,1.7818,1.8877]
var time:int = 0
var releasehelper
var attackhelper
var dualreleasehelper
var dualattackhelper
var sustaincalc
var juststarted:bool = false
var jshelper:float

func _ready():
	OS.open_midi_inputs()
	print(OS.get_connected_midi_inputs())


func _input(input_event):
	if input_event is InputEventMIDI:
		_print_midi_info(input_event)


func _print_midi_info(midi_event):
	midipitch = midi_event.pitch
	#print(notes[midi_event.pitch - 12 * (midi_event.pitch/12)] + str(midi_event.pitch/12))
	#print("Pitch ", midi_event.pitch)
	#print("State ", int(ceil(midi_event.velocity/127.0)))
	if midi_event.velocity > 0:
		whatsletgo[0] = "x"
		latestmidinote = midi_event.pitch
		GlobalVariable.latestnote = midi_event.pitch
	elif latestmidinote == midi_event.pitch:
		whatsletgo[0] = "m"


func _process(_delta: float) -> void:
	if whatsletgo[0] == "x": 
		GlobalVariable.notepressed = true
	elif whatsletgo[1] == "x":
		GlobalVariable.notepressed = true
	else:
		GlobalVariable.notepressed = false
	if Input.is_action_just_pressed("-") and GlobalVariable.keyboardoctave > 2:
		GlobalVariable.keyboardoctave -= 1
	if Input.is_action_just_pressed("+") and GlobalVariable.keyboardoctave < 7:
		GlobalVariable.keyboardoctave += 1
	for i in range(keyboardarr.size()):
		if Input.is_action_just_pressed(keyboardarr[i]):
			latestkeyboardnote = keyboardarr[i]
			#GlobalVariable.latestnote = (12 * (GlobalVariable.keyboardoctave - 2)) + keydownhelparr[i] + 12 * int(log(GlobalVariable.keyboardoctave)/log(2))
			GlobalVariable.latestnote = (12 * (GlobalVariable.keyboardoctave) + keydownhelparr[i])
			whatsletgo[1] = "x"
		if Input.is_action_just_released(keyboardarr[i]):
			if latestkeyboardnote == keyboardarr[i]:
				whatsletgo[1] = "k"


func _on_play_pressed() -> void:
	time = 0
	GlobalVariable.step = 0
	play = true
	juststarted = true

func _on_stop_pressed() -> void:
	play = false
	GlobalVariable.step = 0
	juststarted = false


func _physics_process(_delta: float) -> void:
	if GlobalVariable.mode == "Normal" and play == true:
		time += 1
		if juststarted == true:
			jshelper = 2.0/float(GlobalVariable.bpmsecs)
		if time > GlobalVariable.bpmsecs * jshelper:
			juststarted = false
			jshelper = 1
			if GlobalVariable.step < GlobalVariable.stepamount:
				GlobalVariable.step += 1
			else:
				GlobalVariable.step = 1
			if GlobalVariable.sequence[GlobalVariable.step - 1] > 0:
				playprocess()
			time = 0
	
	
	if GlobalVariable.mode == "Dual" and play == true:
		time += 1
		if juststarted == true:
			jshelper = 2.0/float(GlobalVariable.bpmsecs)
		if time > GlobalVariable.bpmsecs * jshelper:
			juststarted = false
			jshelper = 1
			if GlobalVariable.step < 10 and GlobalVariable.step < GlobalVariable.stepamountdual:
				if GlobalVariable.step == 8:
					GlobalVariable.step = 17
				else:
					GlobalVariable.step += 1
			elif GlobalVariable.step > 16 and GlobalVariable.step < GlobalVariable.stepamountdual + 8 :
				GlobalVariable.step += 1
			else:
				GlobalVariable.step = 1
			if GlobalVariable.step < 10:
				if GlobalVariable.dualsequence[GlobalVariable.step - 1] > 0:
					playprocess()
				if GlobalVariable.dualsequence[GlobalVariable.step - 1 + 16] > 0:
					playprocessdual()
			else:
				if GlobalVariable.dualsequence[GlobalVariable.step - 1 - 8] > 0:
					playprocess()
				if GlobalVariable.dualsequence[GlobalVariable.step - 1 + 8] > 0:
					playprocessdual()
			time = 0
	
	
	if releasehelper == "subtract" and GlobalVariable.release < 10:
		if GlobalVariable.release > 0:
			$NormalAudio.volume_db -= (8.0/6.0) / GlobalVariable.release
		else:
			$NormalAudio.volume_db -= 80
	if attackhelper == "attack" and GlobalVariable.attack > 0 and $NormalAudio.volume_db < 0:
		if releasehelper == "standstill":
			if $NormalAudio.volume_db + (8.0/6.0) / GlobalVariable.attack > 0:
				$NormalAudio.volume_db = 0
			else:
				$NormalAudio.volume_db += (8.0/6.0) / GlobalVariable.attack
	elif $NormalAudio.volume_db >= 0:
		attackhelper = "stop"
	if attackhelper == "stop" and releasehelper == "standstill":
		sustaincalc = (GlobalVariable.sustain/100.0 * 40)
		if $NormalAudio.volume_db - ((40 - sustaincalc)/60) / GlobalVariable.decay > (sustaincalc - 40):
			$NormalAudio.volume_db -= ((40 - sustaincalc)/60) / GlobalVariable.decay
		else:
			releasehelper = "subtract"
			$NormalAudio.volume_db = (sustaincalc - 40)
	
	
	if dualreleasehelper == "subtract" and GlobalVariable.release < 10:
		if GlobalVariable.release > 0:
			$DualAudio.volume_db -= (8.0/6.0) / GlobalVariable.release
		else:
			$DualAudio.volume_db -= 80
	if dualattackhelper == "attack" and GlobalVariable.attack > 0 and $DualAudio.volume_db < 0:
		if dualreleasehelper == "standstill":
			if $DualAudio.volume_db + (8.0/6.0) / GlobalVariable.attack > 0:
				$DualAudio.volume_db = 0
			else:
				$DualAudio.volume_db += (8.0/6.0) / GlobalVariable.attack
	elif $DualAudio.volume_db >= 0:
		dualattackhelper = "stop"
	if dualattackhelper == "stop" and dualreleasehelper == "standstill":
		sustaincalc = (GlobalVariable.sustain/100.0 * 40)
		if $DualAudio.volume_db - ((40 - sustaincalc)/60) / GlobalVariable.decay > (sustaincalc - 40):
			$DualAudio.volume_db -= ((40 - sustaincalc)/60) / GlobalVariable.decay
		else:
			dualreleasehelper = "subtract"
			$DualAudio.volume_db = (sustaincalc - 40)


func playprocess():
	releasehelper = "standstill"
	if GlobalVariable.attack > 0:
		$NormalAudio.volume_db = -80
		attackhelper = "attack"
		$NormalAudio.play()
	else:
		attackhelper = "stop"
		$NormalAudio.volume_db = 0
		$NormalAudio.play()
	if GlobalVariable.mode == "Normal":
		$NormalAudio.pitch_scale = (pitcharray[GlobalVariable.sequence[GlobalVariable.step - 1] - floor(GlobalVariable.sequence[GlobalVariable.step - 1]/12.0) * 12] * (2 ** (floor(GlobalVariable.sequence[GlobalVariable.step - 1]/12.0) - 6)))
	else:
		if GlobalVariable.step < 10:
			$NormalAudio.pitch_scale = (pitcharray[GlobalVariable.dualsequence[GlobalVariable.step - 1] - floor(GlobalVariable.dualsequence[GlobalVariable.step - 1]/12.0) * 12] * (2 ** (floor(GlobalVariable.dualsequence[GlobalVariable.step - 1]/12.0) - 6)))
		else:
			$NormalAudio.pitch_scale = (pitcharray[GlobalVariable.dualsequence[GlobalVariable.step - 1 - 8] - floor(GlobalVariable.dualsequence[GlobalVariable.step - 1 - 8]/12.0) * 12] * (2 ** (floor(GlobalVariable.dualsequence[GlobalVariable.step - 1 - 8]/12.0) - 6)))

func playprocessdual():
	dualreleasehelper = "standstill"
	if GlobalVariable.attack > 0:
		$DualAudio.volume_db = -80
		dualattackhelper = "attack"
		$DualAudio.play()
	else:
		dualattackhelper = "stop"
		$DualAudio.volume_db = 0
		$DualAudio.play()
	if GlobalVariable.step < 10:
		$DualAudio.pitch_scale = (pitcharray[GlobalVariable.dualsequence[GlobalVariable.step - 1 + 16] - floor(GlobalVariable.dualsequence[GlobalVariable.step - 1 + 16]/12.0) * 12] * (2 ** (floor(GlobalVariable.dualsequence[GlobalVariable.step - 1 + 16]/12.0) - 6)))
	else:
		$DualAudio.pitch_scale = (pitcharray[GlobalVariable.dualsequence[GlobalVariable.step - 1 + 8] - floor(GlobalVariable.dualsequence[GlobalVariable.step - 1 + 8]/12.0) * 12] * (2 ** (floor(GlobalVariable.dualsequence[GlobalVariable.step - 1 + 8]/12.0) - 6)))


func _on_dual_pressed() -> void:
	time = 0
	GlobalVariable.step = 0
	GlobalVariable.mode = "Dual"
	juststarted = true

func _on_normal_pressed() -> void:
	time = 0
	GlobalVariable.step = 0
	GlobalVariable.mode = "Normal"
	juststarted = true
