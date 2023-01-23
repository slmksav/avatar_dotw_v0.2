extends Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect('body_entered', self, '_play_location_text')

func _play_location_text(body):
	$AnimationPlayer.play("readsign")
	yield(get_tree().create_timer(3), "timeout")
	$AnimationPlayer.play_backwards("readsign")

