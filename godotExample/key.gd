extends Area2D

@onready var animation = $AnimationPlayer
@export var itemResource: InventoryItem

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_area_entered(area:Area2D):
	animation.play("rotate")
	await animation.animation_finished
	var playerInventory = area.get_parent().get_inventory()
	playerInventory.add(itemResource)
	queue_free()
