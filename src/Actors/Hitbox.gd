extends Node2D

class_name Hitbox


func overlap_tumbleweed(_body):
	_body.gameover = true
	var scene = get_tree().get_current_scene()
	scene.get_node("GameOver/MarginContainer").show()
	scene.get_node("Shader/ColorRect").hide()
