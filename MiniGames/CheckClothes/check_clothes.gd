extends Node

	#NONE, 0
	#FOOD, 1
	#DIRTY, 2
	#CLEAN 3
# Called when the node enters the scene tree for the first time.
func _ready():
	print(Stats.player.object_in_hands)
	if Stats.player.object_in_hands == Stats.player.ObjectHold.CLEAN:
		Stats.player.object_in_hands = Stats.player.ObjectHold.NONE
		get_parent().finish_game()
	else:
		Stats.player.object_in_hands = Stats.player.ObjectHold.DIRTY
		get_parent().cancel_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
