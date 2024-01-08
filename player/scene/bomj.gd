extends CharacterBody2D

@onready var world: World = get_tree().get_current_scene()
@onready var tile_map: TileMap = get_tree().get_current_scene().get_node("TileMap")
@export var mini_game: PackedScene = preload("res://MiniGames/FightBomj/fight_bomj_game.tscn")
@onready var interact_area = $InteractArea

var out: bool = false
var event_started: bool = false

func _ready():
	await get_tree().create_timer(1).timeout
	interact_area.interacted.connect(interacted)
	path = world.find_path(tile_map.local_to_map(position),Vector2i(34,12))
	



@onready var animTree: AnimationTree = $AnimationTree
@onready var animState = animTree.get("parameters/playback")


func interacted():
	if out: return
	
	var mini_game_inst: MiniGame = mini_game.instantiate()
	mini_game_inst.game_finish.connect(out_world)
	interact_area.interacted.disconnect(interacted)
	add_child(mini_game_inst)
	mini_game_inst.visible = true

func out_world():
	path = world.find_path(tile_map.local_to_map(position),Vector2i(80,0))
	out = true

var path: Array

func _physics_process(delta):
	await get_tree().create_timer(1).timeout
	
	
	if path == []: 
		animState.travel("Idle")
		if not event_started:
			event_started = true
		if out:
			queue_free()
		return
	
	var anim_vector = position.direction_to(  tile_map.map_to_local(path[0])  )
	update_blend_position(anim_vector)
	animState.travel("Move")
	
	move()


func move():
	position = position.move_toward(tile_map.map_to_local(path[0]),1.5)
	
	if position == tile_map.map_to_local(path[0]):
		path.remove_at(0)

func update_blend_position(input_vector):
	animTree.set("parameters/Idle/blend_position",input_vector)
	animTree.set("parameters/Dash/blend_position",input_vector)
	animTree.set("parameters/Move/blend_position",input_vector)
	animTree.set("parameters/Attack/blend_position",input_vector)
	animTree.set("parameters/MoveHold/blend_position",input_vector)
