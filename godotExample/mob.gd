extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# random animation
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])

# called when visible_on_screen_notifier tells us that a mob is off-screen
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
