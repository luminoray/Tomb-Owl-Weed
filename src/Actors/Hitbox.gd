extends Node2D

class_name Hitbox


func overlap_tumbleweed(_body):
	var currentScene = get_tree().get_current_scene().get_filename()
	get_tree().change_scene(currentScene)
