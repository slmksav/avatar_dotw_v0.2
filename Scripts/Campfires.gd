extends AnimatedSprite

func _ready():
	$CampfireLight.hide()

func _on_DayNightCycle_sendTorchRequest(torch_on):
	if torch_on:
		self.play("default")
		$CampfireLight.show()
	else:
		self.play("burnt")
		$CampfireLight.hide()
