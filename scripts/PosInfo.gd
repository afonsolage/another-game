extends Label

var _head = null

func _ready():
	_head = get_parent()

func _process(_delta):
	text = "pos: %s" % _head.get_global_transform().basis
	pass
