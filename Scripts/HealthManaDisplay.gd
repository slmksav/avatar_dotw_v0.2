extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var hidden = false

func _input(event):
	if event.is_action_pressed("hide"):
		if hidden == false:
			$Health.hide()
			$Mana.hide()
			hidden = true
		else:
			$Health.show()
			$Mana.show()
			hidden = false
