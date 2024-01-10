extends Control

@onready var _exit_btn:Button = $ButtonsMarginContainer/VBoxContainer/ExitBtn
@onready var _title_lbl: Label = $TitleMarginContainer/TitleLbl
@onready var title_lbl = $TitleMarginContainer/TitleLbl



func _ready():
	_title_lbl.text = "One in hotel"
	if OS.get_name() == "Web":
		_exit_btn.visible = false


func _on_ExitBtn_pressed():
	get_tree().quit()

