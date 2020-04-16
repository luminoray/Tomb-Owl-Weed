extends KinematicBody2D

export var cooldown: = 0.4

var velocity: = Vector2(-64, rand_range(-15, 10))


func _ready() -> void:
	get_node("AnimationPlayer").play("Flap")
	position.y -= rand_range(120, 220)


func _physics_process(_delta: float) -> void:
	move_and_slide(velocity)
