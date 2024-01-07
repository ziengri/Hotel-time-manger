extends Node2D
class_name InteractableItem


@export var event_info : EventInfo 
@onready var interact_area :InteractArea = $InteractArea as InteractArea

@export var mini_game :PackedScene
var room:Room



enum ItemState{
	NonActive,
	Active,
}

var state = ItemState.NonActive 
var game_started: bool = false

func start_event()->void:
	EventManager.add_event(room,event_info)
	state = ItemState.Active
	print("ВОЗОМЖНО ВЗАИМОДЕЙСТВИЕ")

func finish_event()->void:
	EventManager.finish_event(room,event_info)
	state = ItemState.NonActive
	room.visitor.states.change_state(BaseStateVisitor.State.IDLEEVENT)
	game_started = false

# Called when the node enters the scene tree for the first time.
func _ready()->void:
	room = get_parent().get_parent()
	interact_area.interacted.connect(make_interaction)
	#start_event()


func make_interaction()->void:
	if state == ItemState.Active:
		if game_started: return
		
		var mini_game_scene : MiniGame = mini_game.instantiate() as MiniGame
		add_child(mini_game_scene)
		mini_game_scene.visible =true
		mini_game_scene.game_finish.connect(finish_event)
		print("ВЫПОЛНЯЕМ ИГРУ")
		
		game_started = true
	else:
		pass
