extends StaticBody2D

export var cooldown: = 0.75


func _ready() -> void:
	get_node("AnimationPlayer").play("Flash")
	position.y -= rand_range(60, 220)
	
