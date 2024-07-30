extends BaseItem


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func item_action():
	print('item_action')
	var particles: GPUParticles2D = get_node('GPUParticles2D')
	var area: Area2D = get_node("Area2D")
	particles.one_shot = true
	particles.emitting = true
	await particles.finished
	var areas = area.get_overlapping_areas()
	
	print(areas)
	for a in areas:
		var parent = a.get_parent()
		if parent is ShadowClone:
			(parent as ShadowClone).destroy()
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
