extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	if Stats.player.object_in_hands == Stats.player.ObjectHold.FOOD:
		print("ЕДА ЕСТЬ")
		Stats.player.object_in_hands = Stats.player.ObjectHold.NONE
		get_parent().finish_game()
	else:
		print("ЕДА НЕТ")
		get_parent().cancel_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
