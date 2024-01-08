extends Node2D
class_name Room

@export var room_id : int = 1
@onready var inter_items : Node2D = $InterItems
var visitor :CharacterBody2D
@onready var room_position : Marker2D = $Marker2D
@onready var broom :InteractableItem = $Broom
@onready var sign = $Sign/Label


enum RoomStatus{
	FREE,
	BUSY,
	DIRTY,
	CLOSED
}


@export var status : RoomStatus : set = set_status
func set_status(new_status)->void:
	if new_status == RoomStatus.DIRTY:
		broom.visible = true
		sign.text = "X"
		sign.modulate = Color.FIREBRICK
		start_clean_room_event()
	else:
		sign.text = str(room_id)
		sign.modulate = Color.WHITE
		broom.visible = false
	status = new_status
	

func _ready():
	sign.text = str(room_id)


func start_clean_room_event()->void:
	broom.start_event()
	broom.visible = true
	
	
func generate_event():
	var inter_items :Array =$InterItems.get_children() as Array
	var interactable_item : InteractableItem = inter_items.pick_random() as InteractableItem
	
	interactable_item.start_event()


