extends Button


func _on_Continue_pressed() -> void:
	var currentScene = get_tree().get_current_scene().get_filename()
	get_tree().change_scene(currentScene)
