# draw a fake wall on one edge of the polygon
extends Node2D

onready var poly : Polygon2D = get_parent()

export var wall_angle = 210
export var wall_thickness = 10
var wall_dir: Vector2 = Vector2.RIGHT.rotated(deg2rad(wall_angle)) * wall_thickness
export var wall_bot_color: Color = Color.white
export var wall_top_color: Color = Color.black


func _process(_delta):
	wall_dir = (get_viewport().size / 2.0 - get_global_mouse_position()).normalized() * wall_thickness
	update()

func _draw():
	var vertices = poly.polygon
	var normals = []
	var num_of_vertices = vertices.size()
	for vertice_ind in range(num_of_vertices):
		var vertice = vertices[vertice_ind]
		var next_vertice = vertices[(vertice_ind + 1) % num_of_vertices]
		var normal = (next_vertice - vertice).normalized().rotated(PI / 2.0)
		normals.append(normal)
	
	for vertice_ind in range(num_of_vertices):
		var vertice = vertices[vertice_ind]
		var next_vertice = vertices[(vertice_ind + 1) % num_of_vertices]
		var normal = normals[vertice_ind]
		if wall_dir.dot(normal) > 0:
			draw_polygon(PoolVector2Array([vertice, vertice + wall_dir, next_vertice]), PoolColorArray([wall_top_color, wall_bot_color, wall_top_color]))
			draw_polygon(PoolVector2Array([next_vertice, next_vertice + wall_dir, vertice + wall_dir]), PoolColorArray([wall_top_color, wall_bot_color, wall_bot_color]))
