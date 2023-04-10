extends RichTextLabel


onready var Player = $"../../../Wizard"

func _ready():
	self.text = "Scrolls: 0"

func _process(delta):
	self.text = "Scrolls: %s" % Player.collected_scrolls
