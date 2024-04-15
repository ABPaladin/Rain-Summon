extends CanvasLayer

const CHAR_READ_RATE = 0.5

@onready var text_box_container = $TextBoxContainer
@onready var start = $TextBoxContainer/MarginContainer/HBoxContainer/Start
@onready var end = $TextBoxContainer/MarginContainer/HBoxContainer/End
@onready var label = $TextBoxContainer/MarginContainer/HBoxContainer/Label




# Called when the node enters the scene tree for the first time.
func _ready():
	hide_textbox()
	add_text("This text is going to be added!")
	
func hide_textbox():
	start.text = ""
	end.text = ""
	label.text = ""
	text_box_container.hide()
	

func show_textbox():
	start.text = "*"
	text_box_container.show()

func add_text(next_text):
	label.text = next_text
	show_textbox()
	
