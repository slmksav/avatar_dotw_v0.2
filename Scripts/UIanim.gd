extends ColorRect

var previous_player_position = Vector2()

var locationtextregulator = false
func _ready():
	$Area2D.connect("body_entered", self, "_on_player_entered")
	$Area2D.connect("body_exited", self, "_on_player_exited")

func _on_player_entered(body):
	previous_player_position = body.position

func _on_player_exited(body):
	if previous_player_position.y < body.position.y:
		if locationtextregulator == true:
			pass
		else:
			$LabelLocation.set_text("Wu Province, \nBa Sing Se")
			$AnimationPlayer.play("show")
			locationtextregulator = true
			yield(get_tree().create_timer(2), "timeout")
			$AnimationPlayer.play_backwards("show")
			yield(get_tree().create_timer(8), "timeout")
			locationtextregulator = false
	else:
		if locationtextregulator == true:
			pass
		else:
			yield(get_tree().create_timer(4), "timeout")
			$LabelLocation.set_text("Huan Province, \nBa Sing Se")
			$AnimationPlayer.play("show")
			locationtextregulator = true
			yield(get_tree().create_timer(2), "timeout")
			$AnimationPlayer.play_backwards("show")
			# Cooldown
			yield(get_tree().create_timer(8), "timeout")
			locationtextregulator = false
