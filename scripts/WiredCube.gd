extends ImmediateGeometry

var vertices = [Vector3(0,0,0), Vector3(1,0,0), Vector3(1,1,0), Vector3(0,1,0), 
	Vector3(0,0,1), Vector3(1,0,1), Vector3(1,1,1), Vector3(0,1,1)]

func _process(delta):
	clear()
	begin(1, null) #1 = is an enum for draw line, null is for text
	
	add_vertex(vertices[0])
	add_vertex(vertices[1])
	add_vertex(vertices[1])
	add_vertex(vertices[2])
	add_vertex(vertices[2])
	add_vertex(vertices[3])
	add_vertex(vertices[3])
	add_vertex(vertices[0])
	
	add_vertex(vertices[1])
	add_vertex(vertices[5])
	add_vertex(vertices[5])
	add_vertex(vertices[6])
	add_vertex(vertices[6])
	add_vertex(vertices[2])
	add_vertex(vertices[2])
	add_vertex(vertices[1])
	
	add_vertex(vertices[4])
	add_vertex(vertices[5])
	add_vertex(vertices[5])
	add_vertex(vertices[6])
	add_vertex(vertices[6])
	add_vertex(vertices[7])
	add_vertex(vertices[7])
	add_vertex(vertices[4])
	
	add_vertex(vertices[0])
	add_vertex(vertices[4])
	add_vertex(vertices[4])
	add_vertex(vertices[7])
	add_vertex(vertices[7])
	add_vertex(vertices[3])
	add_vertex(vertices[3])
	add_vertex(vertices[0])
	
	end()
