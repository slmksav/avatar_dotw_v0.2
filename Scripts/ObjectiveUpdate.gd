extends ColorRect

var previous_player_position = Vector2()

var journalhidden = true
var hidden = false
var hidetut = false
func _ready():
	$Objectives.set_text("[J]   new entries")
	$Control.hide()
	$ObjectivesSymbol.add_color_override("font_color", Color.darkred)
	$ObjectivesSymbol.set_text("")
	
	$ObjectiveLocation.add_color_override("font_color", Color.yellowgreen)
	$ObjectiveLocation.set_text("2")

	$Tutorial.add_color_override("font_color", Color.white)
	$Tutorial.set_text("Press [H] to toggle HUD on/off")
func _input(event):
	if event.is_action_pressed("journal"):
		if journalhidden == false:
			$Control.hide()
			journalhidden = true
		else:
			$Control.show()
			journalhidden = false

	if event.is_action_pressed("hide"):
		if hidden == false:
			$Objectives.hide()
			$ObjectivesSymbol.hide()
			$ObjectiveLocation.hide()
			$Tutorial.hide()
			hidden = true
			hidetut = true
		else:
			$Objectives.show()
			$ObjectivesSymbol.show()
			$ObjectiveLocation.show()
			hidden = false
