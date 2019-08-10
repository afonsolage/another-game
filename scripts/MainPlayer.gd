extends Spatial

# Declare member variables here. Examples:
export var move_speed = 10
export var turn_speed = 0.4
export var min_angle = -90
export var max_angle = 90
export var boost_speed = 2

export(NodePath) var terrain_path = null
export(NodePath) var wired_cube_path = null
export(NodePath) var pos_info_path = null

var _yaw = 0
var _pitch = 0
var _transform_dirty = true
var _terrain = null
var _wired_cube = null
var _position_info = null
var _gizmo = null

const Util = preload("res://scripts/utils.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	_terrain = get_node(terrain_path)
	_wired_cube = get_node(wired_cube_path)
	_position_info = get_node(pos_info_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		return
	
	var forward = get_global_transform().basis.z.normalized()
	var right = get_global_transform().basis.x.normalized()
	var up = get_global_transform().basis.y.normalized()
	
	var move = Vector3()
	
	if Input.is_key_pressed(KEY_S):
		move += forward * move_speed * delta
	
	if Input.is_key_pressed(KEY_W):
		move += forward * move_speed * -1 * delta
	
	if Input.is_key_pressed(KEY_D):
		move += right * move_speed * delta
	
	if Input.is_key_pressed(KEY_A):
		move += right * move_speed * -1 * delta
	
	if Input.is_key_pressed(KEY_SPACE):
		move += up * move_speed * delta
		
	if Input.is_key_pressed(KEY_CONTROL):
		move += up * move_speed * -1 * delta
		
	if Input.is_key_pressed(KEY_SHIFT):
		move *= boost_speed
	
	if (move != Vector3.ZERO):
		global_translate(move)
		_transform_dirty = true
		
	if _transform_dirty:
		update_rotations()
	
	update_target()
	
func _input(event):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE && \
		not (event is InputEventKey && event.pressed && event.scancode == KEY_ESCAPE):
		return
		
	if event is InputEventMouseMotion:
		
		var motion = event.relative
		
		_yaw -= motion.x * turn_speed
		_pitch += motion.y * turn_speed
		
		var e = 0.001
		if _pitch > max_angle - e:
			_pitch = max_angle - e
		elif _pitch < min_angle  + e:
			_pitch = min_angle + e
		
		_transform_dirty = true
	
	elif event is InputEventKey:
		if event.pressed && event.scancode == KEY_ESCAPE:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED)
			
	elif event is InputEventMouseButton:
		
		if event.pressed:
			if event.button_index == BUTTON_LEFT:
				set_target_voxel()
			elif event.button_index == BUTTON_RIGHT:
				remove_target_voxel()

func update_rotations():
	set_rotation(Vector3(0, deg2rad(_yaw), 0))
	rotate(get_transform().basis.x.normalized(), -deg2rad(_pitch))
	_transform_dirty = false

func update_target():
	var hit = get_target_voxel()
	if hit == null:
		return
	
	_position_info.text = "pos: %s \ntarget: %s" % [get_global_transform().origin, hit.position]
	_wired_cube.set_global_transform(Transform(Basis(Vector3.ZERO), hit.position))

func get_target_voxel():
	var origin = get_global_transform().origin
	var forward = -get_global_transform().basis.z.normalized()
	var hit = _terrain.raycast(origin, forward, 20)
	return hit

func remove_target_voxel():
	var hit = get_target_voxel()
	
	if hit != null:
		_terrain.get_storage().set_voxel_v(0, hit.position)
		_terrain.make_voxel_dirty(hit.position)

func set_target_voxel():
	var hit = get_target_voxel()
	
	if hit != null:
		_terrain.get_storage().set_voxel_v(1, hit.prev_position)
		_terrain.make_voxel_dirty(hit.prev_position)
