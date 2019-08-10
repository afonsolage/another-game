extends Spatial

var array_quad_vertices = []
var array_quad_indices = []

var dictionary_check_quad_vertices = {}

export(NodePath) var main_player = null

var _main_player: Spatial = null

func _ready():
	if main_player != null:
		_main_player = get_node(main_player)
	
	var x_axis = make_cube(Color.red)
	x_axis.name = "x_axis"
	x_axis.scale = Vector3(0.04, 0.004, 0.004)
	x_axis.translate(Vector3(0, 0, 0.6))
	x_axis.rotate_y(-PI)
	add_child(x_axis)
	
	var y_axis = make_cube(Color.green)
	y_axis.name = "y_axis"
	y_axis.scale = Vector3(0.004, 0.04, 0.004)
	add_child(y_axis)
	
	var z_axis = make_cube(Color.blue)
	z_axis.name = "z_axis"
	z_axis.scale = Vector3(0.004, 0.004, 0.04)
	add_child(z_axis)
	
	var center = make_cube(Color.gray)
	center.scale = Vector3(0.01, 0.01, 0.01)
	center.translate(Vector3(-0.3, -0.3, -0.3))
	add_child(center)
	
	translate(Vector3(-0.45, 0.4, 0))

func make_cube(color: Color, from = 0, to = 1):
	array_quad_vertices = []
	array_quad_indices = []
	dictionary_check_quad_vertices = {}
	
	var surface_tool = SurfaceTool.new()
	
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES)
	surface_tool.add_color(color)
	add_quad(Vector3(from, from, to), Vector3(to, from, to), Vector3(to, from, from), Vector3(from, from, from))
	add_quad(Vector3(from, to, to), Vector3(from, to, from), Vector3(to, to, from), Vector3(to, to, to))
	
	add_quad(Vector3(to, to, from), Vector3(from, to, from), Vector3(from, from, from), Vector3(to, from, from))
	add_quad(Vector3(to, to, to), Vector3(to, from, to), Vector3(from, from, to), Vector3(from, to, to))
	
	add_quad(Vector3(from, to, to), Vector3(from, from, to), Vector3(from, from, from), Vector3(from, to, from))
	add_quad(Vector3(to, to, to), Vector3(to, to, from), Vector3(to, from, from), Vector3(to, from, to))
	
	for vertex in array_quad_vertices:
		surface_tool.add_vertex(vertex)
		
	for index in array_quad_indices:
		surface_tool.add_index(index)
	
	surface_tool.generate_normals()
	var cube = MeshInstance.new()
	cube.mesh = surface_tool.commit()
	
	var material = SpatialMaterial.new()
	material.vertex_color_use_as_albedo = true
	cube.set_surface_material(0, material)
	return cube
	

func add_quad(point_1, point_2, point_3, point_4):
	
	var vertex_index_one = -1
	var vertex_index_two = -1
	var vertex_index_three = -1
	var vertex_index_four = -1
	
	vertex_index_one = _add_or_get_vertex_from_array(point_1)
	vertex_index_two = _add_or_get_vertex_from_array(point_2)
	vertex_index_three = _add_or_get_vertex_from_array(point_3)
	vertex_index_four = _add_or_get_vertex_from_array(point_4)
	
	array_quad_indices.append(vertex_index_one)
	array_quad_indices.append(vertex_index_two)
	array_quad_indices.append(vertex_index_three)
	
	array_quad_indices.append(vertex_index_one)
	array_quad_indices.append(vertex_index_three)
	array_quad_indices.append(vertex_index_four)

func _add_or_get_vertex_from_array(vertex):
	if dictionary_check_quad_vertices.has(vertex) == true:
		return dictionary_check_quad_vertices[vertex]

	else:
		array_quad_vertices.append(vertex)
		dictionary_check_quad_vertices[vertex] = array_quad_vertices.size() - 1
		return array_quad_vertices.size() - 1

func _process(delta):
	if _main_player == null:
		return
		
	rotation = _main_player.rotation
