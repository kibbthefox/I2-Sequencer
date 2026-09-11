extends Button

func _on_pressed() -> void:
	if GlobalVariable.page == 0:
		GlobalVariable.page = 1
	else:
		GlobalVariable.page = 0


func _process(_delta: float) -> void:
	if GlobalVariable.page == 0:
		$".".position.x = 1063.0
		$".".position.y = 212.0
		$".".rotation = PI / -2
	if GlobalVariable.page == 1:
		$".".position.x = 49.0
		$".".position.y = 212.0
		$".".rotation = PI / 2
