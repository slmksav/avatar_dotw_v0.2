extends Light2D


func _on_DayNightCycle_sendTorchRequest(torch_on):
	if torch_on:
		enabled = not enabled
	else:
		enabled = not enabled
