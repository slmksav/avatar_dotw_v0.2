extends CanvasLayer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Fader.hide()

func _on_PlayerTent_letsleep():
	$Fader.show()
	$AnimationPlayer.play("Fading")
