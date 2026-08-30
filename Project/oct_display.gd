extends RichTextLabel

func _process(_delta: float) -> void:
	$".".text = "Oct: " + str(GlobalVariable.keyboardoctave)
