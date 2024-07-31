extends Area2D
class_name TailwindActive

@onready var particles: GPUParticles2D = get_node('GPUParticles2D')
var team: int = 0
# Called when the node enters the scene tree for the first time.
func start():
	particles.one_shot = true
	particles.emitting = true
	await particles.finished
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body is ShadowClone && (body as ShadowClone).team != team:
			(body as ShadowClone).move_forward()
	queue_free()
