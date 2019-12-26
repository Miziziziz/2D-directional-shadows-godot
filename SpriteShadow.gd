# create a polygon on a sprite by duplicating a mask of it a bunch of times
extends Node2D

onready var main_sprite : Sprite = get_parent()
var shadow_dir : Vector2
export var num_shadow_sprites = 12
var shadow_sprite = preload("res://ShadowSprite.tscn")

export var shadow_start_color = Color.black
export var shadow_end_color = Color(0, 0, 0, 0)

func _ready():
	for i in range(num_shadow_sprites):
		var sprite : Sprite = shadow_sprite.instance()
		sprite.texture = main_sprite.texture
		sprite.hframes = main_sprite.hframes
		sprite.vframes = main_sprite.vframes
		add_child(sprite)

func _process(_delta):
	shadow_dir = get_viewport().size / 2.0 - get_global_mouse_position()
	
	for i in range(num_shadow_sprites):
		var sprite : Sprite = get_child(i)
		var t = (i + 1.0) / num_shadow_sprites
		sprite.modulate = shadow_start_color.linear_interpolate(shadow_end_color, t)
		sprite.position = shadow_dir * t
		sprite.frame = main_sprite.frame
		