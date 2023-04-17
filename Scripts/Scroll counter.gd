extends RichTextLabel


onready var Player = $"../../../Wizard"

onready var total_scrolls = $"../../../Scrolls".get_child_count()

func _ready():
	self.bbcode_text = " 0"

func _process(delta):
	self.bbcode_text = " %s/%s" % [Player.collected_scrolls, total_scrolls]
