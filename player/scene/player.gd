extends CharacterBody2D


@export var move_speed : float = 124


var direction : Vector2


@onready var states: StateMachine = $States
@onready var animTree: AnimationTree = $AnimationTree
@onready var animState = animTree.get("parameters/playback")



func _ready():
	states.init(self)
	animTree.active = true


func _unhandled_input(event):
	states.input(event)
	if Input.is_action_just_pressed("ui_select"):
		return


func _physics_process(delta):
	states.physics_process(delta)

func update_blend_position(input_vector):
	animTree.set("parameters/Idle/blend_position",input_vector)
	animTree.set("parameters/Dash/blend_position",input_vector)
	animTree.set("parameters/Move/blend_position",input_vector)
	animTree.set("parameters/Attack/blend_position",input_vector)
	animTree.set("parameters/MoveHold/blend_position",input_vector)
	direction = input_vector





