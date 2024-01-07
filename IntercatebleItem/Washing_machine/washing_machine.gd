extends Sprite2D

@onready var interact_area: InteractArea = $InteractArea
@export var mini_game: PackedScene = preload("res://MiniGames/Washing/washing_game.tscn")

func _ready():
	interact_area.interacted.connect(interacted)


func interacted():
	if Stats.player.object_in_hands == Stats.player.ObjectHold.DIRTY:
		var mini_game_inst: MiniGame = mini_game.instantiate()
		mini_game_inst.game_finish.connect(give_eat)
		add_child(mini_game_inst)
		mini_game_inst.visible = true

func give_eat():
	Stats.player.object_in_hands = Stats.player.ObjectHold.CLEAN
