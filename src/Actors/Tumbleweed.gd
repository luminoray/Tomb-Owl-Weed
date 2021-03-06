extends KinematicBody2D

onready var sprite = $tumbleweed
onready var diameter = sprite.texture.get_size().x
onready var start = position.x
onready var counter = get_parent().get_parent().get_node('UI/Control/Label')

export var velocity: = Vector2.ZERO
export var base_gravity: = 320.0
export var jumps: = 2
export var jump_power: = 200
export var gliding_factor: = 0.15
export var action_buffer: = 0.1

var new_velocity
var score = 0
var on_floor
var can_jump = jumps
var jump_buffer: = 0.0
var can_glide = true
var gliding = false
var gravity = base_gravity

func _process(_delta: float) -> void:
	counter.text = str(floor(score))

func _physics_process(delta: float) -> void:
	sprite.rotation_degrees += (velocity.x / (diameter * PI)) * (360 * delta) * (.5 if ! on_floor else 1.0) * (.25 if gliding else 1.0)
	velocity.y += gravity * delta * (gliding_factor if gliding else 1.0)
	
	process_input()
	process_buffers()
	
	new_velocity = move_and_slide(velocity)
	
	velocity.y = new_velocity.y
	
	score += velocity.x * delta * 0.1

	if (position.x > start + diameter):
		position.x -= diameter
		for actor in get_parent().get_node('Obstacles').get_children():
			actor.position.x -= diameter
		
	on_floor = false
	
	process_collisions()


func process_input() -> void:
	if Input.is_action_just_pressed('jump'):
		if can_jump > 0:
			jump()
		else:
			jump_buffer = action_buffer
	
	if Input.is_action_pressed('glide') and can_glide and velocity.y >= 0:
		velocity.y = 0
		gliding = true
		can_glide = false
	
	if Input.is_action_just_released('glide'):
		gliding = false


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
		var collision = get_slide_collision(i)
		
		can_jump = jumps
		can_glide = false
		gliding = false
		on_floor = true
		if rand_range(0, 1) < 0.5 * get_process_delta_time():
			velocity.y = -60
				
	
