extends RichTextLabel

var Notes:Array = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B",]

func _process(_delta: float) -> void:
	if GlobalVariable.sequence[int(get_parent().name) - 1] <= 0 or int(get_parent().name) > GlobalVariable.stepamount:
		$".".text = "--"
	else:
		$".".text = (Notes[GlobalVariable.sequence[int(get_parent().name) - 1] - floor(GlobalVariable.sequence[int(get_parent().name) - 1]/12.0) * 12] + str(int(floor(GlobalVariable.sequence[int(get_parent().name) - 1]/12.0))))

#func _ready() -> void:
	#print(Notes[GlobalVariable.sequence[int(get_parent().name) - 1] - floor(GlobalVariable.sequence[int(get_parent().name) - 1]/12.0) * 12] + str(int(floor(GlobalVariable.sequence[int(get_parent().name) - 1]/12.0))))
