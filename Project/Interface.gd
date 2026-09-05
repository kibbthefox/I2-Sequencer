extends Node2D

var BPMcalc:float
var play:bool = false
var mode:String = "Normal"
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
			GlobalVariable.latestnote = (12 * (GlobalVariable.keyboardoctave - 2)) + keydownhelparr[i] + 12 * int(log(GlobalVariable.keyboardoctave)/log(2))
			whatsletgo[1] = "x"
		if Input.is_action_just_released(keyboardarr[i]):
			if latestkeyboardnote == keyboardarr[i]:
				whatsletgo[1] = "k"

# make time be 2 for first time through so playing starts quicker

#ASDINYASDUOYSABDFHP*(ASYDBASD

func _physics_process(_delta: float) -> void:
	if mode == "Normal" and play == true:
		time += 1
		if time > GlobalVariable.bpmsecs:
			if GlobalVariable.step < GlobalVariable.stepamount:
				GlobalVariable.step += 1
			else:
				GlobalVariable.step = 1
			if GlobalVariable.sequence[GlobalVariable.step - 1] > 0:
				$NormalAudio.pitch_scale = (pitcharray[GlobalVariable.sequence[GlobalVariable.step - 1] - floor(GlobalVariable.sequence[GlobalVariable.step - 1]/12.0) * 12] * (2 ** (floor(GlobalVariable.sequence[GlobalVariable.step - 1]/12.0) - 6)))
				$NormalAudio.play()
			time = 0


func _on_play_pressed() -> void:
	time = 0
	play = true


func _on_stop_pressed() -> void:
	play = false
	GlobalVariable.step = 0
