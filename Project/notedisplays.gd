extends RichTextLabel

var Notes:Array = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B",]
var step:int
var dualstep:int

func _process(_delta: float) -> void:
	if get_parent().position.y > 0:
		dualstep = int(get_parent().name) - 8 + GlobalVariable.page * 8
	else:
		dualstep = int(get_parent().name) + GlobalVariable.page * 8
	step = int(get_parent().name) - 1 + GlobalVariable.page * 16
	if GlobalVariable.mode == "Normal" and GlobalVariable.sequence[step] <= 0 or GlobalVariable.mode == "Normal" and step + 1 > GlobalVariable.stepamount:
		$".".text = "--"
	elif GlobalVariable.mode == "Dual" and GlobalVariable.sequence[step] <= 0 or GlobalVariable.mode == "Dual" and dualstep > GlobalVariable.stepamountdual:
		$".".text = "--"
	else:
		$".".text = (Notes[GlobalVariable.sequence[step] - floor(GlobalVariable.sequence[step]/12.0) * 12] + str(int(floor(GlobalVariable.sequence[step]/12.0))))
