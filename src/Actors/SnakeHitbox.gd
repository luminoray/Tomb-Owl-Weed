extends Hitbox


var played = false

func overlap_tumbleweed(_body):
	_body.velocity.y = -550
	_body.can_jump = 1
	_body.can_glide = 1
	_body.gliding = false

	get_parent().get_node("AnimationPlayer").play("Pop")
	if ! played:
		get_parent().get_node("AudioStreamPlayer2D").play()
		played = true
