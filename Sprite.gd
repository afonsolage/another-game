extends Sprite

func _ready():
	texture = get_parent().get_node("ViewportContainer/Viewport3D").get_texture()
