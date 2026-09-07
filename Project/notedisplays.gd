extends RichTextLabel

var Notes:Array = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B",]
@onready var step = int(get_parent().name) - 1 + GlobalVariable.page * 16

func _process(_delta: float) -> void:
	step = int(get_parent().name) - 1 + GlobalVariable.page * 16
	if GlobalVariable.sequence[step] <= 0 or step + 1 > GlobalVariable.stepamount:
		$".".text = "--"
	else:
		$".".text = (Notes[GlobalVariable.sequence[step] - floor(GlobalVariable.sequence[step]/12.0) * 12] + str(int(floor(GlobalVariable.sequence[step]/12.0))))
