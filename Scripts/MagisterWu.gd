extends KinematicBody2D

signal who_says_to_console(assign_to_string)
signal say_to_console(assign_to_string)

var target
var randomnum
var speed = 75
var inside = false
var start_time
var generic1_cooldown = false

onready var sound_step_left = $SpeakOut
onready var speakout2 = $SpeakOut2
onready var player : KinematicBody2D = $"../Player"

var last_direction = Vector2(0, 1)
var player_chase = false

enum  {
SURROUND,
ATTACK,
HIT,
}

var threshold = 60.0 # set the threshold value

func _physics_process(delta):
	var direction = (player.get_global_position() - get_global_position()).normalized()
	var distance = player.get_global_position().distance_to(get_global_position())

	if distance <= threshold && player_chase == false:
		direction = Vector2.ZERO # stop moving
	elif distance <= threshold && player_chase == true:
		var movement = speed * direction * delta
		movement = 1.8 * movement
		move_and_collide(movement)
	else:
		var movement = speed * direction * delta
		move_and_collide(movement)
	animates_npc(direction)

func animates_npc(direction: Vector2):
	if direction != Vector2.ZERO:
		last_direction = direction
		var animation = get_animation_direction(last_direction) + "_walk"
		$Sprite.frames.set_animation_speed(animation, 2 + 8 * direction.length())
		$Sprite.play(animation)
	elif direction != Vector2.ZERO && player_chase == true:
		last_direction = direction
		var animation = get_animation_direction(last_direction) + "_walk"
		$Sprite.frames.set_animation_speed(animation, 4 + 16 * direction.length())
		$Sprite.play(animation)
	else:
		var animation = get_animation_direction(last_direction) + "_idle"
		$Sprite.play(animation)

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
				emit_signal("say_to_console", "Earth Bender: \nI got your back, let's go.")
			elif random_float >= 0.125 and random_float < 0.25:
				speakout2.play()
				emit_signal("say_to_console", "Earth Bender: \nWe got to get moving.")
			elif random_float >= 0.25 and random_float < 0.375:
				emit_signal("say_to_console", "Earth Bender: \nNo time for rest.")
				speakout2.play()
			elif random_float >= 0.375 and random_float < 0.5:
				speakout2.play()
				emit_signal("say_to_console", "Earth Bender:\nHey, we got to move.")
			elif random_float >= 0.5 and random_float < 0.625:
				sound_step_left.play()
				emit_signal("say_to_console", "Earth Bender:\nI'll follow your lead.")
			elif random_float >= 0.625 and random_float < 0.75:
				speakout2.play()
				emit_signal("say_to_console", "Earth Bender: \nWe can talk later.")
			elif random_float >= 0.75 and random_float < 0.875:
				sound_step_left.play()
				emit_signal("say_to_console", "Earth Bender: \nI can't talk right now.")
			elif random_float >= 0.875:
				sound_step_left.play()
				emit_signal("say_to_console", "Earth Bender: \nLet's get a move on.")
			$Expressions.show()
			generic1_cooldown = true
			last_message_time = OS.get_ticks_msec()


func _on_Player_player_running():
	player_chase = true


func _on_Player_player_walking():
	player_chase = false
