extends CanvasLayer
class_name MiniGame

signal game_finish

func finish_game()->void:
	print("finish")
	game_finish.emit()
	queue_free()


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	get_child(0).global_position.x+= 100
	get_child(0).global_position.y+= 50



