extends Node2D

onready var body = get_parent().get_node("Tumbleweed")


func _process(_delta):
	for i in get_children():
		var hitbox = i.get_node('Hitbox')
		if hitbox.overlaps_area(body.get_node("Hurtbox")):
			hitbox.overlap_tumbleweed(body)
