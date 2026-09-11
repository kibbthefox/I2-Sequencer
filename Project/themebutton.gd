extends Button

var rgbbg = preload("res://Assets/Theme Buttons/RainbowButton.png")
var blubg = preload("res://Assets/Theme Buttons/BlueButton.png")



func _on_pressed() -> void:
	self.position.x = 1088.0
	self.position.y = 584.0
	if self.icon == rgbbg:
		self.icon = blubg
		$"../BG Blue".visible = false
	else:
		self.icon = rgbbg
		$"../BG Blue".visible = true
