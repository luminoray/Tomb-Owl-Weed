extends Hitbox


func overlap_tumbleweed(_body):
	_body.velocity.y = -600
	_body.can_jump = 1
	_body.can_glide = 1
	_body.gliding = false

	get_parent().get_node("AnimationPlayer").play("Pop")
