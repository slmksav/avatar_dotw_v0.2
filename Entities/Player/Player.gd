extends KinematicBody2D

#Signals
signal player_stats_changed
signal player_running
signal player_walking

# Player movement speed
export var speed = 75
# Player stats
var health = 100
var health_max = 100
var health_regeneration = 1
var mana = 100
var mana_max = 100
var mana_regeneration = 2
var last_direction = Vector2(0, 1)
# Handles blinking
var should_play_blink = false
var attack_playing = false
var label_location
var footsteps_cooldown = false
var canmove
var running = false
var running_sound_cooldown = false

onready var footsteps = $Footsteps
onready var running_sound = $Running

func _ready():
	emit_signal("player_stats_changed", self)
	

func _physics_process(delta):
	# Get player input
	var direction: Vector2
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# If input is digital, normalize it for diagonal movement
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()
	# Apply movement
	var movement = speed * direction * delta
	if running == true:
		movement = 1.8 * movement
	if attack_playing || canmove == false:
		movement = 0 * movement
	move_and_collide(movement)
	# Animate player based on direction
	if not attack_playing:
		animates_player(direction)

func animates_player(direction: Vector2):
	
	if direction != Vector2.ZERO:
		# Update last_direction
		last_direction = direction
		if Input.is_action_pressed("ui_shift"):
			running = true
			# Choose walk animation based on movement direction
			var animation = get_animation_direction(last_direction) + "_walk"
			emit_signal("player_running")
			$Sprite.frames.set_animation_speed(animation, 8 + 16 * direction.length())
			# Play the assigned walk animation
			$Sprite.play(animation)
		else:
			running = false
			emit_signal("player_walking")
			# Choose walk animation based on movement direction
			var animation = get_animation_direction(last_direction) + "_walk"
			$Sprite.frames.set_animation_speed(animation, 2 + 8 * direction.length())
			# Play the assigned walk animation
			$Sprite.play(animation)
	else:
		# If the random number is less than or equal to 0.5, play the blink animation
		if should_play_blink == true:
			var animation = get_animation_direction(last_direction) + "_blink"
			$Sprite.play(animation)
		# Otherwise, play the assigned idle animation
		else:
			var animation = get_animation_direction(last_direction) + "_idle"
			$Sprite.play(animation)
	if footsteps_cooldown == false && direction != Vector2.ZERO:
		footsteps.play()
		footsteps_cooldown = true
	elif running_sound_cooldown == false && direction != Vector2.ZERO && running:
		running_sound.play()
		running_sound_cooldown = true
		

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

func _on_Sprite_animation_finished():
	attack_playing = false
	# Turns blink off by default
	should_play_blink = false
	# Generate a random number between 0 and 1
	var random_num = randf()
	# 15% chance of toggling blink on again
	if random_num <= 0.15:
		should_play_blink = not should_play_blink

func _input(event):
	if event.is_action_pressed("attack"):
		if mana >= 25:
			mana = mana - 25
			emit_signal("player_stats_changed", self)
			attack_playing = true
			var animation = get_animation_direction(last_direction) + "_attack"
			$Sprite.play(animation)
	elif event.is_action_pressed("rockball"):
		if mana >= 50:
			mana = mana - 50
			emit_signal("player_stats_changed", self)
			attack_playing = true
			var animation = get_animation_direction(last_direction) + "_fireball"
			$Sprite.play(animation)

func _process(delta):
	# Regenerates mana
	var new_mana = min(mana + mana_regeneration * delta, mana_max)
	if new_mana != mana:
		mana = new_mana
		emit_signal("player_stats_changed", self)

	# Regenerates health
	var new_health = min(health + health_regeneration * delta, health_max)
	if new_health != health:
		health = new_health
		emit_signal("player_stats_changed", self)


func _on_Timer_timeout():
	footsteps_cooldown = false


func _on_PlayerTent_cantmovewhilesleeping():
	canmove = false


func _on_PlayerTent_canmovewellrested():
	canmove = true


func _on_RunningTimer_timeout():
	running_sound_cooldown = false
