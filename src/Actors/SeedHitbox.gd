extends Hitbox


func overlap_tumbleweed(_body):
	if _body.seeds < 10:
		_body.seeds += 1
	var actor = get_parent()
	actor.get_parent().remove_child(actor)
