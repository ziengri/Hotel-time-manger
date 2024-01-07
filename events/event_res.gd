extends Resource
class_name EventInfo

@export var Alias : String = "event"
@export var Img : Texture = Texture.new()
@export var Reward : int = 0
@export var Time_to_event : int = 0
@export var After_Action : after_actions
enum after_actions{
	DEFAULT,
	ROOM_CLEAR
}
