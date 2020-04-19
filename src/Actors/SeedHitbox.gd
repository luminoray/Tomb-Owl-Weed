extends Hitbox


func overlap_tumbleweed(_body):
	if _body.seeds < 10:
		_body.seeds += 1
	var actor = get_parent()
	_body.get_node("CollectPlayer2D").play()
	actor.get_parent().remove_child(actor)
	
