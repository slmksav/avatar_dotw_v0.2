extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _on_Player_player_stats_changed(var player):
	$Bar.rect_size.x = 40 * player.mana / player.mana_max
