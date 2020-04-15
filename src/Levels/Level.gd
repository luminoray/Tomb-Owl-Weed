extends Node2D

var actors = [
	load("res://src/Actors/Cactus.tscn"),
	load("res://src/Actors/Rock.tscn")
]

var cooldown: = 1.0

func _process(delta: float) -> void:
	if cooldown <= 0:
		if rand_range(0, 1) < (1 * get_process_delta_time()) or cooldown < -2:
			var scene = actors[randi() % actors.size()].instance()
			print(get_viewport_rect().size.x)
			scene.position = Vector2(get_viewport_rect().size.x + scene.get_node('sprite').texture.get_size().x, get_viewport_rect().size.y - 32)
			get_node('Actors/Obstacles').add_child(scene)
			cooldown = scene.cooldown
		
	cooldown -= delta
	print(cooldown)
