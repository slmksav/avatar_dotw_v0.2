extends VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_EarthNationSoldier1_say_to_console(string: String):
		$Line.set_text(string)
		print(string)
		$AnimationPlayer.play("SpeechNormal")
		yield(get_tree().create_timer(5), "timeout")
		clear_Line1()

func clear_Line1():
	$AnimationPlayer.play_backwards("SpeechNormal")
	
func _on_EarthNationSoldier1_who_says_to_console(string: String):
	$Header.set_text(string)

func _on_OldDaiLi_say_to_console(string: String):
		$Line.set_text(string)
		print(string)
		$AnimationPlayer.play("SpeechNormal")
		yield(get_tree().create_timer(5), "timeout")
		clear_Line1()


func _on_OldDaiLi_who_says_to_console(string: String):
	$Header.set_text(string)

func _on_Shopkeeper_say_to_console(string: String):
		$Line.set_text(string)
		print(string)
		$AnimationPlayer.play("SpeechNormal")
		yield(get_tree().create_timer(5), "timeout")
		clear_Line1()

