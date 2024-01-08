extends Node2D
class_name InteractableItem


@export var event_info : EventInfo 
@onready var interact_area :InteractArea = $InteractArea as InteractArea
@onready var sprite : Sprite2D = $Sprite2D

@export var mini_game :PackedScene
var room:Room



enum ItemState{
	NonActive,
	Active,
}

var state :ItemState = ItemState.NonActive : set = set_state
func set_state(new_state):
	if new_state == ItemState.NonActive : sprite.material.set('shader_parameter/line_thickness',0.0)
	if new_state == ItemState.Active : sprite.material.set('shader_parameter/line_thickness',1.0)
	state = new_state

var game_started: bool = false

func start_event()->void:
	EventManager.add_event(room,event_info)
	state = ItemState.Active
	print("ВОЗОМЖНО ВЗАИМОДЕЙСТВИЕ")

func finish_event()->void:
	Stats.player.set_physics_process(true)
	print("Поставили тру 1")
	EventManager.finish_event(room,event_info)
	state = ItemState.NonActive
	if event_info.After_Action != event_info.after_actions.ROOM_CLEAR:
		room.visitor.states.change_state(BaseStateVisitor.State.IDLEEVENT)
	game_started = false

# Called when the node enters the scene tree for the first time.
func _ready()->void:
	if event_info.After_Action == event_info.after_actions.ROOM_CLEAR:
		room = get_parent()
	else:
		room = get_parent().get_parent()	
	interact_area.interacted.connect(make_interaction)
	#start_event()


func make_interaction()->void:
	if state == ItemState.Active:
		if game_started: return
		Stats.player.set_physics_process(false)
		print("Поставили фалсу 2")
		var mini_game_scene : MiniGame = mini_game.instantiate() as MiniGame
		mini_game_scene.game_finish.connect(finish_event)
		mini_game_scene.game_cancel.connect(cancel_interct)
		print("ВЫПОЛНЯЕМ ИГРУ")
		
		game_started = true
		add_child(mini_game_scene)
		mini_game_scene.visible =true
	else:
		pass
func cancel_interct():
	print("CANCEL ИГРУ")
	game_started = false
	Stats.player.set_physics_process(true)
	print("Поставили тру 3")

