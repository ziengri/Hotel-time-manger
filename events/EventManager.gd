extends Node


var eventList :Dictionary = {} 
signal event_list_removed
signal event_list_added


func add_event(room:Room,event_info:EventInfo)->void:
	var timer : Timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = event_info.Time_to_event
	timer.timeout.connect(on_event_fail.bind(room,event_info))
	if event_info.After_Action != event_info.after_actions.ROOM_CLEAR:
		timer.start()
	
	add_to_eventList(room,event_info,timer)
	print(eventList)



func finish_event(room:Room,event_info:EventInfo)->void:
	if event_info.After_Action == event_info.after_actions.ROOM_CLEAR:
		room.status = Room.RoomStatus.FREE
	remove_event_from_list(room,event_info)
	give_reward(event_info)
	print(eventList)
	
	

func remove_event_from_list(room:Room,event_info:EventInfo)->void:
	event_list_removed.emit(room.room_id,eventList[room])
	eventList[room]['timer'].queue_free()
	eventList.erase(room)


	
func add_to_eventList(room:Room,event_info:EventInfo,timer:Timer)->void:
	eventList[room]={'event_info':event_info,'timer':timer}
	event_list_added.emit(room.room_id,eventList[room])
	
	
func on_event_fail(room:Room,event_info:EventInfo)->void:
	room.visitor.states.change_state(BaseStateVisitor.State.IDLEEVENT)	
	var inter_items_node = room.get_child(0)
	var inter_items = inter_items_node.get_children()
	for inter_item in inter_items:
		print(inter_item.get_name())
		inter_item.state = InteractableItem.ItemState.NonActive
		if inter_item.get_name() == "TV":
			if inter_item.get_child(inter_item.get_child_count()-1).get_name() == "TvRepairGame":
				Stats.player.set_physics_process(true)
				inter_item.get_child(inter_item.get_child_count()-1).queue_free()
	remove_event_from_list(room,event_info)
	Stats.stars-=1
	print("EVENT FAIL")

func give_reward(event_info :EventInfo) ->void:
	Stats.money += event_info.Reward


