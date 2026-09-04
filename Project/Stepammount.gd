extends RichTextLabel


func _process(_delta: float) -> void:
	GlobalVariable.stepamount = int($".".text)


func _on_stepsdown_pressed() -> void:
	if int($".".text) > 4:
		$".".text = str(int($".".text) - 1)


func _on_stepsup_pressed() -> void:
	if int($".".text) < 16:
		$".".text = str(int($".".text) + 1)
