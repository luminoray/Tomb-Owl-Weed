extends KinematicBody2D

onready var sprite = $tumbleweed
onready var diameter = sprite.texture.get_size().x
onready var start = position.x
onready var counter = get_parent().get_parent().get_node("UI/Control/Label")
onready var seed_counter = get_parent().get_parent().get_node("UI/Control/LabelSeed")
onready var seed_icon = get_parent().get_parent().get_node("UI/Control/Seed")
onready var plant = get_parent().get_node("Plant")

export var velocity: = Vector2(0, -1)
export var base_gravity: = 640.0
export var jumps: = 2
export var jump_power: = 200
export var gliding_factor: = 0.15
export var action_buffer: = 0.1

const MAX_SEEDS = 10

var start_pos
var new_velocity
var score = 0
var on_floor
var can_jump = jumps
var jump_buffer: = 0.0
var can_glide = false
var gliding = false
var gravity: = base_gravity
var gameover = false
var seeds: = 5


func _ready() -> void:
	 start_pos = position.y


func _process(_delta: float) -> void:
	counter.text = str(floor(score))
	seed_counter.text = str(seeds) + " / " + str(MAX_SEEDS)
	if seeds < 5:
		seed_icon.frame = 1
	else:
		seed_icon.frame = 0
	

func _physics_process(delta: float) -> void:
	if gameover == false and visible == true:
		sprite.rotation_degrees += (velocity.x / (diameter * PI)) * (360 * delta) * (.5 if ! on_floor else 1.0) * (.25 if gliding else 1.0)
		velocity.y += gravity * delta * (gliding_factor if gliding else 1.0)
		
		process_input()
		process_buffers()
		
		new_velocity = move_and_slide(velocity)
		
		velocity.y = new_velocity.y
		
		score += velocity.x * delta * 0.1
	
		if (position.x > start + diameter):
			plant.position.x -= diameter
			position.x -= diameter
			for actor in get_parent().get_node('Obstacles').get_children():
				actor.position.x -= diameter
			
		on_floor = false
		
		process_collisions()


func process_input() -> void:
	if Input.is_action_just_pressed('jump'):
		if position.y >= get_viewport_rect().size.y - 64:
			land()
			jump()
		elif can_jump > 0:
			jump()
		else:
			jump_buffer = action_buffer
	
	if Input.is_action_pressed('glide') and can_glide and velocity.y >= 0:
		velocity.y = 0
		gliding = true
		can_glide = false
	
	if Input.is_action_just_released('glide'):
		gliding = false
		
	if Input.is_action_just_pressed("seed"):
		if seeds >= 5:
			plant.visible = true
			plant.position.x = position.x
			plant.score = score
			plant.get_node("AnimationPlayer").play()
			seeds -= 5


func process_buffers() -> void:
	if jump_buffer > 0 and can_jump > 0:
		jump_buffer = -1
		jump()
	jump_buffer -= get_process_delta_time() * 10


func jump() -> void:
	velocity.y = -(jump_power + can_jump * 100)
	can_jump -= 1
	can_glide = true
	gliding = false
	gravity = base_gravity


func process_collisions() -> void:
	for i in get_slide_count():
		land()
		if rand_range(0, 1) < 1 * get_process_delta_time():
			velocity.y = -30
				
	

func land() -> void:
	can_jump = jumps
	can_glide = false
	gliding = false
	on_floor = true
