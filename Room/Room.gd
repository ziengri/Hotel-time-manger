extends Node2D
class_name Room

@export var room_id : int = 1
@onready var inter_items : Node2D = $InterItems
var visitor :CharacterBody2D
@onready var room_position : Marker2D = $Marker2D
@onready var broom :InteractableItem = $Broom


enum RoomStatus{
	FREE,
	BUSY,
	DIRTY,
	CLOSED
}

@export var status : RoomStatus : set = set_status
func set_status(new_status)->void:
	if new_status == RoomStatus.DIRTY:
		start_clean_room_event()
	status = new_status
	

func start_clean_room_event()->void:
	broom.start_event()
	
	
func generate_event():
	var inter_items :Array =$InterItems.get_children() as Array
	var interactable_item : InteractableItem = inter_items.pick_random() as InteractableItem
	
	interactable_item.start_event()


