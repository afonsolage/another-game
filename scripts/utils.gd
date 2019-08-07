static func to_dir_vec(v: Vector3):
	if abs(v.x) > abs(v.y) && abs(v.x) > abs(v.z):
		return Vector3.RIGHT if v.x > 0 else Vector3.LEFT
	elif abs(v.y) > abs(v.x) && abs(v.y) > abs(v.z):
		return Vector3.UP if v.y > 0 else Vector3.DOWN
	elif abs(v.z) > abs(v.x) && abs(v.z) > abs(v.y):
		return Vector3.FORWARD if v.z > 0 else Vector3.BACK
	else:
		return Vector3.ZERO

