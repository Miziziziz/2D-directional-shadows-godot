# create a directional shadow from a polygon
extends Node2D

var poly : Polygon2D = null

var shadow_dir: Vector2
export var shadow_color: Color = Color.black
export var shadow_end_color: Color = Color(0, 0, 0, 0)
func _ready():
	poly = get_parent()
	

func _process(_delta):
	shadow_dir = get_viewport().size / 2.0 - get_global_mouse_position()
	update()

func _draw():
	var vertices = poly.polygon
	var num_of_vertices = vertices.size()
	for vertice_ind in range(num_of_vertices):
		var vertice = vertices[vertice_ind]
		var next_vertice = vertices[(vertice_ind + 1) % num_of_vertices]
		var normal = (next_vertice - vertice).normalized().rotated(PI / 2.0)
		if shadow_dir.dot(normal) > 0:
			draw_polygon(PoolVector2Array([vertice, vertice + shadow_dir, next_vertice]), PoolColorArray([shadow_color, shadow_end_color, shadow_color]))
			draw_polygon(PoolVector2Array([next_vertice, next_vertice + shadow_dir, vertice + shadow_dir]), PoolColorArray([shadow_color, shadow_end_color, shadow_end_color]))
