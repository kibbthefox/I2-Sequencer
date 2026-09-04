extends RichTextLabel

func _process(_delta: float) -> void:
	$".".text = str(GlobalVariable.keyboardoctave)


func _on_octdown_pressed() -> void:
	if GlobalVariable.keyboardoctave > 2:
		GlobalVariable.keyboardoctave -= 1


func _on_octup_pressed() -> void:
	if GlobalVariable.keyboardoctave < 7:
		GlobalVariable.keyboardoctave += 1
