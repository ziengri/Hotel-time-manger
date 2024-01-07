extends Node2D

@onready var washing_machine_clothes :Area2D = $WashingMashineClothes/Area2D
@onready var washing_machine_open :Area2D = $WashingMashineOpen/Area2D
@onready var washing_machine :Area2D = $WashingMashine/Area2D
@onready var pregress_bar :ProgressBar = $Container/ProgressBar


@onready var washing_machine_game :Node2D = $Mashine_full
@onready var hint :Label  =$Container/Label
# Called when the node enters the scene tree for the first time.
func _ready():
	washing_machine.input_event.connect(open_machine)
	washing_machine.mouse_entered.connect(func(): print('hello!'))

func open_machine(viewport, event:InputEventMouseButton, shape_idx):
	print(event)
	if event.button_index == 1:
		washing_machine_open.get_parent().visible=true
		washing_machine.get_parent().visible=false
		washing_machine.input_event.disconnect(open_machine)
		hint.text= "Положи вещи в стиралку"
		await get_tree().create_timer(1.0).timeout
		washing_machine_open.input_event.connect(load_machine)
	
func load_machine(viewport, event:InputEventMouseButton, shape_idx):
	if event.button_index == 1:
		washing_machine_clothes.get_parent().visible=true
		washing_machine_open.get_parent().visible=false
		washing_machine_open.input_event.disconnect(load_machine)
		hint.text= "Закрой дверцу"
		await get_tree().create_timer(1.0).timeout
		washing_machine_clothes.input_event.connect(close_machine)
	
func close_machine(viewport, event:InputEventMouseButton, shape_idx):
	if event.button_index == 1:
		washing_machine_game.visible=true
		washing_machine_clothes.get_parent().visible=false
		washing_machine_clothes.input_event.disconnect(load_machine)
		hint.text= "А теперь крути баран по часов стрелке"
		pregress_bar.max_value = washing_machine_game.MAX_NEED_ROTATION_DEGRESS
		washing_machine_game.progress_bar = pregress_bar
		await get_tree().create_timer(0.1).timeout
		washing_machine_game.process_mode = Node.PROCESS_MODE_PAUSABLE

func finish_game():
	await get_tree().create_timer(2).timeout
	hint.text= "Готово"
	get_parent().finish_game()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

