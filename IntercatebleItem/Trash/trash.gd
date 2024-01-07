extends Sprite2D

@onready var interact_area: InteractArea = $InteractArea
@export var mini_game: PackedScene = preload("res://MiniGames/Coocing/coocing.tscn")

func _ready():
	interact_area.interacted.connect(interacted)


func interacted():
	print(Stats.player.object_in_hands)
	if Stats.player.object_in_hands == Stats.player.ObjectHold.FOOD:
		Stats.player.object_in_hands = Stats.player.ObjectHold.NONE
		print(false)

