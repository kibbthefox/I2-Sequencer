extends RichTextLabel


func _process(_delta: float) -> void:
	if self.name == "octdisplay":
		$".".text = str(GlobalVariable.keyboardoctave)
	if self.name == "stepsdisplay":
		$".".text = str(GlobalVariable.stepamount)
	if self.name == "attackdisplay":
		$".".text = str(GlobalVariable.attack) + " secs"
	if self.name == "releasedisplay":
		$".".text = str(GlobalVariable.release) + " secs"
	if self.name == "decaydisplay":
		$".".text = str(GlobalVariable.decay) + " secs"
	if self.name == "sustaindisplay":
		$".".text = str(GlobalVariable.sustain) + " %"
	if self.name == "mididisplay":
		if str(OS.get_connected_midi_inputs()) == "[]":
			$".".text = " No MIDI Keyboard Detected"
		else:
			$".".text = " MIDI Connected: " + str(OS.get_connected_midi_inputs())


func _on_octdown_pressed() -> void:
	if GlobalVariable.keyboardoctave > 2:
		GlobalVariable.keyboardoctave -= 1


func _on_octup_pressed() -> void:
	if GlobalVariable.keyboardoctave < 7:
		GlobalVariable.keyboardoctave += 1


func _on_stepsdown_pressed() -> void:
	if GlobalVariable.stepamount > 4:
		GlobalVariable.stepamount -= 1


func _on_stepsup_pressed() -> void:
	if GlobalVariable.stepamount < 32:
		GlobalVariable.stepamount += 1
