extends RichTextLabel

var tween

func _ready() -> void:
	modulate.a = 0.0


func _process(_delta: float) -> void:
	$".".text = " " + GlobalVariable.filetext
	if GlobalVariable.justopened == true:
		appear()
		GlobalVariable.justopened = false


func appear():
	modulate.a = 1.0
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 3.0)
	await tween.finished
