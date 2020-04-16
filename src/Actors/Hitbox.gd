extends Node2D

class_name Hitbox


func overlap_tumbleweed(_body):
	_body.gameover = true
	get_tree().get_current_scene().get_node("GameOver/MarginContainer").show()
