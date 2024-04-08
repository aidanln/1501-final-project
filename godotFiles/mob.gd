extends CharacterBody2D
@onready var path_follow = get_parent()
var speed = 320
var direction = 0

signal playerDetected

# Called when the node enters the scene tree for the first time.
func _ready():
	# random animation
	$AnimatedSprite2D.play("walk")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var prepos = path_follow.get_global_position()
	path_follow.set_progress(path_follow.get_progress() + speed * delta)
	var pos = path_follow.get_global_position()
	direction = (pos.angle_to_point(prepos)/3.14)*180

# will only be called on the player entering (i.e. collision layer 4)
func _on_area_2d_body_entered(_body:Node2D):
	playerDetected.emit()
