extends Button

onready var currentScene = get_tree().get_current_scene()
onready var weed = currentScene.get_node("Actors/Tumbleweed")
onready var plant = currentScene.get_node("Actors/Plant")

func _process(delta: float) -> void:
	if plant.score == 0:
		text = 'Restart'
	else:
		text = 'Continue'

func _on_Continue_pressed() -> void:
	weed.gameover = false
	weed.position.y = weed.start_pos
	weed.velocity.y = 0
	weed.score = plant.score
	weed.visible = false
	
	if weed.score == 0:
		weed.seeds = 5
	
	plant.position.x = weed.position.x
	plant.visible = true
	
	currentScene.get_node("GameOver/MarginContainer").hide()
	currentScene.get_node("Shader/ColorRect").show()
	for actor in currentScene.get_node("Actors/Obstacles").get_children():
		actor.get_parent().remove_child(actor)
