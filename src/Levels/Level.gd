extends Node2D

var actors = [
	{
		"chance": 0.5, 
		"resource": load("res://src/Actors/Cactus.tscn")
	},
	{
		"chance": 0.35, 
		"resource": load("res://src/Actors/Rock.tscn")
	},
	{
		"chance": 0.15, 
		"resource": load("res://src/Actors/Snake.tscn")
	}
]

var overlaid_actors = [
	{
		"chance": 0.85, 
		"resource": load("res://src/Actors/Bird.tscn")
	},
	{
		"chance": 0.15, 
		"resource": load("res://src/Actors/Seed.tscn")
	}
]

onready var weed = get_node("Actors/Tumbleweed")

var cooldown: = 1.0
var overlaid_cooldown: = 1.0
var scene
var day_cycle = 0
var enviro_cycle = 0

func _ready() -> void:
	get_node("AudioStreamPlayer2D").play()


func _process(_delta: float) -> void:
	if weed.gameover == false and weed.visible == true:
		random_spawn_actor()
		random_spawn_overlaid_actor()
	if weed.gameover == false:
		process_ambience()


func random_spawn_actor():
	var rng_accumulator: = 0.0
	if cooldown <= 0:
		if rand_range(0, 1) < (1 * get_process_delta_time()) or cooldown < -2:
			var rng = rand_range(0, 1)
			for actor in actors:
				rng_accumulator += actor["chance"]
				if rng < rng_accumulator:
					scene = actor["resource"].instance()
					rng_accumulator = 0
					break
			scene.position = Vector2(get_viewport_rect().size.x + scene.get_node('sprite').texture.get_size().x, get_viewport_rect().size.y - 32)
			get_node('Actors/Obstacles').add_child(scene)
			cooldown = scene.cooldown
		
	cooldown -= get_process_delta_time()
	

func random_spawn_overlaid_actor():
	var rng_accumulator: = 0.0
	if overlaid_cooldown <= 0:
		if rand_range(0, 1) < (.5 * get_process_delta_time()) or overlaid_cooldown < -2:
			var rng = rand_range(0, 1)
			for actor in overlaid_actors:
				rng_accumulator += actor["chance"]
				if rng < rng_accumulator:
					scene = actor["resource"].instance()
					rng_accumulator = 0
					break
			scene.position = Vector2(get_viewport_rect().size.x + scene.get_node('sprite').texture.get_size().x, get_viewport_rect().size.y - 32)
			get_node('Actors/Obstacles').add_child(scene)
			overlaid_cooldown = scene.cooldown
		
	overlaid_cooldown -= get_process_delta_time()

func process_ambience():
	day_cycle = floor((int(get_node("Actors/Tumbleweed").score) % 1000) / 100)
	if day_cycle == 0:
		get_node("Shader/ColorRect").color = Color(1, 1, 0.87, 1)
	elif day_cycle == 4 or day_cycle == 9:
		get_node("Shader/ColorRect").color = Color(0.9, 0.9, 0.83, 1)
	elif day_cycle == 5:
		get_node("Shader/ColorRect").color = Color(0.85, 0.85, 0.9, 1)
		
	enviro_cycle = floor((int(get_node("Actors/Tumbleweed").score) % 3000) / 1000)
	if enviro_cycle == 0:
		get_node("UI/pyramid").visible = true
		get_node("UI/dunes").visible = false
		get_node("UI/city").visible = false
	elif enviro_cycle == 1:
		get_node("UI/pyramid").visible = false
		get_node("UI/dunes").visible = true
		get_node("UI/city").visible = false
	elif enviro_cycle == 2:
		get_node("UI/pyramid").visible = false
		get_node("UI/dunes").visible = false
		get_node("UI/city").visible = true
