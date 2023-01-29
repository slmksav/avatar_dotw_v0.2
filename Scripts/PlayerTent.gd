extends Sprite

signal letsleep
signal cantmovewhilesleeping
signal canmovewellrested

var cansleep = false
var wantstosleep = false
var sleepcooldown = false

func _ready():
	$Area2D.connect('body_entered', self, '_play_location_text')
	$Label.hide()
	$ZZZZ.hide()
	$Fader.hide()
	$CanOnlySleepDuringNight.hide()
	$SleepCooldown.hide()

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		$Label.show()
		if wantstosleep && cansleep == true && sleepcooldown == false:
			emit_signal("cantmovewhilesleeping")
			$Fader.show()
			$ZZZZ.show()
			$AnimationPlayer2.play("ZZZZ")
			$AnimationPlayer.play("Fade")
			$Snore.play()
			yield(get_tree().create_timer(5), "timeout")
			$AnimationPlayer.play_backwards("Fade")
			$AnimationPlayer2.play_backwards("ZZZZ")
			$ZZZZ.hide()
			emit_signal("canmovewellrested")
			cansleep = false
			wantstosleep = false
			sleepcooldown = true
		elif wantstosleep && cansleep == false && sleepcooldown == false:
			$CanOnlySleepDuringNight.show()
			yield(get_tree().create_timer(1), "timeout")
			$CanOnlySleepDuringNight.hide()
			wantstosleep = false
		if sleepcooldown == true:
			$SleepCooldown.show()
			yield(get_tree().create_timer(1), "timeout")
			$SleepCooldown.hide()

func _on_Area2D_body_exited(body):
	$Label.hide()

func _input(event):
		if event.is_action_pressed("interact"):
			wantstosleep = true

func _on_DayNightCycle_sendTorchRequest(torch_on):
	cansleep = true
