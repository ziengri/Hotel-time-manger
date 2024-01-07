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



