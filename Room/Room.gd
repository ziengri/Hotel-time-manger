extends Node2D
class_name Room

@export var room_id : int = 1
@onready var inter_items : Node2D = $InterItems
var visitor :CharacterBody2D
@onready var room_position : Marker2D = $Marker2D


enum RoomStatus{
	FREE,
	BUSY,
	DIRTY,
	CLOSED
}

@export var status : RoomStatus 


func generate_event():
	var inter_items :Array =$InterItems.get_children() as Array
	var interactable_item : InteractableItem = inter_items.pick_random() as InteractableItem
	
	interactable_item.start_event()


