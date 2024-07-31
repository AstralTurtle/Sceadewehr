extends BaseItem

func item_action():
	print('item_action')
	var particles: GPUParticles2D = get_node('GPUParticles2D')
	var area: Area2D = get_node("Area2D")
	particles.one_shot = true
	particles.emitting = true
	await particles.finished
	var areas = area.get_overlapping_bodies()
	print(areas)
	for a in areas:
		if a is ShadowClone:
			(a as ShadowClone).apply_stun()
	queue_free()
