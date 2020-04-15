extends Node2D

onready var body = get_parent().get_node("Tumbleweed")


func _process(_delta):
	for i in get_children():
		if i.get_node('Hitbox').overlaps_body(body):
			var currentScene = get_tree().get_current_scene().get_filename()
			print(get_tree().change_scene(currentScene)) # for Debug

