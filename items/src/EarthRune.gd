extends BaseItem


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func item_action():
	(get_node('Area2D') as Area2D).body_entered.connect(trigger_rune)

func trigger_rune(body: Node2D):
	if (body is ShadowClone && (body as ShadowClone).team != player):
		(body as ShadowClone).apply_stun()
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
