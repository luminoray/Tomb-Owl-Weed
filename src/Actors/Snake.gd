extends StaticBody2D

export var cooldown: = 1


var bonus_seed = load("res://src/Actors/Seed.tscn")


func _enter_tree() -> void:
	if rand_range(0,1) < 0.5:
		var scene = bonus_seed.instance()
		get_parent().add_child(scene)
		scene.position = Vector2(780, 16)
