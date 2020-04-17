extends Node2D

var score = 0


onready var weed = get_parent().get_node("Tumbleweed")
var timer = 2

func _ready() -> void:
	get_node("AnimationPlayer").play("Growth")


func _process(delta: float) -> void:
	if weed.visible == false:
		timer -= delta
		
	if timer <= 0:
		timer = 2
		visible = false
		score = 0
		weed.visible = true
		weed.velocity.y = -120
