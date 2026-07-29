extends Node2D

var BPMcalc:float
var step:int = 0
var play:bool = false
var mode:String = "Normal"
var notes:Array = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B"]
var notepressedcount:int = 0
var midipitch:int = -1

func _ready():
	OS.open_midi_inputs()
	print(OS.get_connected_midi_inputs())


func _input(input_event):
	if input_event is InputEventMIDI:
		_print_midi_info(input_event)


func _print_midi_info(midi_event):
	midipitch = midi_event.pitch
	print(notes[midi_event.pitch - 12 * (midi_event.pitch/12)] + str(midi_event.pitch/12))
	print("Pitch ", midi_event.pitch)
	print("State ", int(ceil(midi_event.velocity/127.0)))
	if midi_event.velocity > 0:
		notepressedcount += 1
		GlobalVariable.latestnote = midi_event.pitch
	else:
		notepressedcount -= 1

func _process(_delta: float) -> void:
	if play == true and mode == "Normal":
		await get_tree().create_timer(60.0/GlobalVariable.BPM).timeout
		$NormalAudio.play()
	if notepressedcount > 0:
		GlobalVariable.notepressed = true
	else:
		GlobalVariable.notepressed = false
