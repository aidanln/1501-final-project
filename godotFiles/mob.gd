extends CharacterBody2D
@onready var path_follow = get_parent()
var speed = 350
var direction = 0

# either 0 or 1, decides which way the butler will travel the path
var path_dir = (randi() % 2)

signal playerDetected

# Called when the node enters the scene tree for the first time.
func _ready():
	# random animation
	$AnimatedSprite2D.play("walk")
	print(path_dir)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var prepos = path_follow.get_global_position()
	if (path_dir):
		path_follow.set_progress(path_follow.get_progress() - (speed * delta))
	else:
		path_follow.set_progress(path_follow.get_progress() + (speed * delta))
	var pos = path_follow.get_global_position()
	direction = (pos.angle_to_point(prepos)/3.14)*180

# will only be called on the player entering (i.e. collision layer 4)
func _on_area_2d_body_entered(_body:Node2D):
	playerDetected.emit()

# Randomizes butler spawn
func spawn_butler():
	var prepos = path_follow.get_global_position()
	path_follow.set_progress_ratio(randf())
	var pos = path_follow.get_global_position()
	direction = (pos.angle_to_point(prepos)/3.14)*180
