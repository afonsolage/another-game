extends ImmediateGeometry

var vertices = [Vector3(-0.001,-0.001,-0.001), Vector3(1.001,-0.001,-0.001), Vector3(1.001,1.001,-0.001), Vector3(-0.001,1.001,-0.001), 
	Vector3(-0.001,-0.001,1.001), Vector3(1.001,-0.001,1.001), Vector3(1.001,1.001,1.001), Vector3(-0.001,1.001,1.001)]

func _ready():
	var mat = SpatialMaterial.new()
	mat.flags_use_point_size = true
	mat.params_point_size = 5
	mat.vertex_color_use_as_albedo = true
	set_material_override(mat)

func _process(_delta):
	clear()
	
	begin(Mesh.PRIMITIVE_LINE_LOOP)
	set_color(Color.black)
	add_vertex(vertices[0])
	add_vertex(vertices[1])
	add_vertex(vertices[2])
	add_vertex(vertices[3])
	end()
	
	begin(Mesh.PRIMITIVE_LINE_LOOP)
	set_color(Color.black)
	add_vertex(vertices[1])
	add_vertex(vertices[5])
	add_vertex(vertices[6])
	add_vertex(vertices[2])
	end()
	
	begin(Mesh.PRIMITIVE_LINE_LOOP)
	set_color(Color.black)
	add_vertex(vertices[4])
	add_vertex(vertices[5])
	add_vertex(vertices[6])
	add_vertex(vertices[7])
	end()
	
	begin(Mesh.PRIMITIVE_LINE_LOOP)
	set_color(Color.black)
	add_vertex(vertices[0])
	add_vertex(vertices[4])
	add_vertex(vertices[7])
	add_vertex(vertices[3])
	end()
