extends CharacterBody2D

signal hit

@export var speed = 500 # player speed (pixels/sec)
@export var inventory: Inventory
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction : 
		self.velocity = direction * speed
	else :
		self.velocity = Vector2.ZERO
		
	move_and_slide()
	
	if self.velocity.length() > 0:
		self.velocity = self.velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "walk"
	
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func get_inventory() :
	return inventory
