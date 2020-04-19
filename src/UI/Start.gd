extends Button

var next_scene = preload("res://src/Levels/LevelTest.tscn")


func _on_Start_pressed() -> void:
	get_tree().change_scene_to(next_scene)
