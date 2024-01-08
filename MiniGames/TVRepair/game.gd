extends Node2D

@onready var white_noise = $AnimatedSprite2D
@onready var television_button = $TelevisionButton

var need_rotation_degress :int
var inaccuracy_degress : int = 100
@onready var timer :Timer = $Timer


var timer_started : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(on_find_degress)
	need_rotation_degress = randi_range(2500,4000)#6000
	print(need_rotation_degress)
	white_noise.play("default")
	white_noise.modulate = Color(1,1,1,1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var btn_degress = 0
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		television_button.look_at(get_viewport().get_mouse_position())
		btn_degress = television_button.rotation_degrees
		var proximity_to_need_degress = (abs(need_rotation_degress - btn_degress) / need_rotation_degress )
		print(btn_degress)
		print(proximity_to_need_degress)
		white_noise.self_modulate = Color(1,1,1,proximity_to_need_degress)
	if  btn_degress <= (need_rotation_degress+inaccuracy_degress) and btn_degress>= (need_rotation_degress-inaccuracy_degress):
				white_noise.self_modulate = Color(1,1,1,0)
				if timer_started == false:
					print("TIMER IS STOPPED")
					timer.start(3)
					timer_started = true
					print("TIMER STARt")
	else:
		if timer_started == true:
			timer.stop()
			timer_started = false
			print("TIMER STOP")
		
		#print(	television_button.rotation_degrees)


func on_find_degress()->void:
	print("Finish")
	set_process(false)
	get_parent().finish_game()

