extends KinematicBody2D

signal who_says_to_console(assign_to_string)
signal say_to_console(assign_to_string)

var target
var randomnum
var speed = 30
var inside = false
var start_time
var generic1_cooldown = false

onready var sound_step_left = $SpeakOut
onready var speakout2 = $SpeakOut2
onready var player : KinematicBody2D = $"../Player"

var last_direction = Vector2(0, 1)

#var threshold = 50.0 # set the threshold value

func get_animation_direction(direction: Vector2):
	var norm_direction = direction.normalized()
	if norm_direction.y >= 0.707:
		return "down"
	elif norm_direction.y <= -0.707:
		return "up"
	elif norm_direction.x <= -0.707:
		return "left"
	elif norm_direction.x >= 0.707:
		return "right"
	return "down"

func _ready():
	$Area2D.connect('body_entered', self, '_play_location_text')
	$Expressions.hide()
	
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		start_time = OS.get_ticks_msec()
		inside = true
		
func _on_Area2D_body_exited(body):
	inside = false
	emit_signal("who_says_to_console", "")
var last_message_time = 0

func _process(delta):
	if inside && OS.get_ticks_msec() - start_time > 4000:
			_play_location_text()
	if OS.get_ticks_msec() - last_message_time > 8000:
		$Expressions.hide()
		generic1_cooldown = false

func _play_location_text():
	if generic1_cooldown == false:
		var random_float = randf()
		if inside == true:
			emit_signal("who_says_to_console", "")
			if random_float < 0.125:
				sound_step_left.play()
				emit_signal("say_to_console", "Dai Li: \nWhat are you standing there for?")
			elif random_float >= 0.125 and random_float < 0.25:
				speakout2.play()
				emit_signal("say_to_console", "Dai Li: \nYou've no reason to be here.")
			elif random_float >= 0.25 and random_float < 0.375:
				emit_signal("say_to_console", "Dai Li: \nStand back, civilian.")
				speakout2.play()
			elif random_float >= 0.375 and random_float < 0.5:
				speakout2.play()
				emit_signal("say_to_console", "Dai Li:\nMove along, citizen.")
			elif random_float >= 0.5 and random_float < 0.625:
				sound_step_left.play()
				emit_signal("say_to_console", "Dai Li:\nThis area is off-limits.")
			elif random_float >= 0.625 and random_float < 0.75:
				speakout2.play()
				emit_signal("say_to_console", "Dai Li: \nYour papers, please.")
			elif random_float >= 0.75 and random_float < 0.875:
				sound_step_left.play()
				emit_signal("say_to_console", "Dai Li: \nI'm not allowed to talk.")
			elif random_float >= 0.875:
				sound_step_left.play()
				emit_signal("say_to_console", "Dai Li: \nGet a move on!")
			$Expressions.show()
			generic1_cooldown = true
			last_message_time = OS.get_ticks_msec()
